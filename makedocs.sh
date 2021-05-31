#/bin/sh
git checkout gh-pages
git merge origin/main --commit
jazzy
git add .
git commit -m "New docs"
git push