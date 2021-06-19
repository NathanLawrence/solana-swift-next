//
//  URLSession+WebSocketPublisher.swift
//  
//
//  Created by Nathan Lawrence on 6/9/21.
//

import Foundation
import Combine

extension URLSession {
    /**
     A Publisher that emits URLSession web socket messages until a connection is terminated.
     */
    func webSocketPublisher(for request: URLRequest) -> WebSocketPublisher {
        return WebSocketPublisher(request: request, session: self)
    }
}

struct WebSocketPublisher: Publisher {
    typealias Output = URLSessionWebSocketTask.Message
    typealias Failure = WebSocketError

    let request: URLRequest
    let session: URLSession

    func receive<S>(subscriber: S)
        where S : Subscriber, WebSocketError == S.Failure,
        URLSessionWebSocketTask.Message == S.Input {
            subscriber.receive(subscription: WebSocketSubscription(self, subscriber))
    }

    private final class WebSocketSubscription<Target: Subscriber>: OptionalActor, Subscription
        where Target.Input == WebSocketPublisher.Output,
        Target.Failure == WebSocketPublisher.Failure {

            private var target: Target?
            private var demand: Subscribers.Demand = .max(0)
            private var publisher: WebSocketPublisher?
            private var task: URLSessionWebSocketTask?


            init(_ publisher: WebSocketPublisher, _ target: Target) {
                self.target = target
                self.publisher = publisher
            }

            func request(_ demand: Subscribers.Demand) {
                let task = locked { () -> URLSessionWebSocketTask in
                    wireIfNeeded()
                    self.demand = self.demand + demand

                    guard let task = self.task else {
                        preconditionFailure("Task was not set by wire method. Was request(_:) called after cancellation?")
                    }

                    return task
                }

                task.receive(completionHandler: messageReceiveHandler(with:))
                task.resume()
            }

            private func messageReceiveHandler(with result: Result<WebSocketPublisher.Output, Error>) {
                let activeTarget = locked { () ->  Target? in
                    guard self.demand > 0,
                          publisher != nil,
                          task != nil,
                          let target = target else {
                              return nil
                          }

                    demand = demand - 1
                    return target
                }

                guard let target = activeTarget else {
                    // If demand is not occurring,
                    // due to cancellation or precondition,
                    // do nothing.
                    return
                }

                switch result {
                case .success(let message):
                    let freshDemand = target.receive(message)
                    locked {
                        demand += freshDemand
                    }
                    task?.receive(completionHandler: messageReceiveHandler(with:))
                case .failure(let error):
                    let wrappedError = WebSocketError.urlSessionError(error)
                    target.receive(completion: .failure(wrappedError))
                }
            }

            func wireIfNeeded() {
                guard let publisher = publisher else {
                    // This could be nil after cancellation.
                    return
                }

                guard task == nil else {
                    // This could be called overzealously.
                    return
                }

                let task = publisher
                    .session
                    .webSocketTask(with: publisher.request)
                self.task = task
            }

            func cancel() {
                let currentTask = locked { () -> URLSessionWebSocketTask? in
                    guard publisher != nil else {
                        return nil
                    }
                    publisher = nil
                    target = nil
                    demand = .max(0)
                    let returningTask = self.task
                    self.task = nil
                    return returningTask
                }

                currentTask?.cancel(with: .normalClosure, reason: nil)
            }
    }
}

public enum WebSocketError: Error {
    case urlSessionError(Error)
}
