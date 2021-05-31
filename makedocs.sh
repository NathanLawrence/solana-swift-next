#/bin/sh
git checkout gh-pages
git merge origin/main --commit
jazzy
git add .
git commit -m "New docs"
git push
curl -s \
  --form-string "token=ay3gqh9e4kpd9i7bf99v4i5jxz8tia" \
  --form-string "user=u6pezkwysz6z2iqi9ugqy5susa1osu" \
  --form-string "message=New Docs Pushed" \
  https://api.pushover.net/1/messages.json