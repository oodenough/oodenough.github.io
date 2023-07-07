---
categories: 2023 04
tags: [git]
---

### two types of github pages
[user/organization pages](https://help.github.com/articles/user-organization-and-project-pages#user--organization-pages) is named as `username.github.io` published at `main` branch and can be browsed at `https://username.github.io`

[project-pages](https://help.github.com/articles/user-organization-and-project-pages#project-pages) can be part of any repository, and are published from the special gh-pages branch. They can be browsed at `https://username.github.io/project-name`



### add gh-pages branch
first create a public repo named `yourblog` and add git connection
```bash
git branch gh-pages #==> add gh-pages branch
git checkout gh-pages #==> change to gh-pages branch
ehco "hello world" >> index.html
git add .
git commit -m "gh-pages"
git push -u origin gh-pages #==> push to remote gh-pages branch
```
then browse to `https://username.github.io/yourblog`

### deploy gh-pages
head to the repo on github and click
settings => pages => deploy from gh-pages branch

##### docs
[gh-pages_stackoverflow](https://stackoverflow.com/questions/25559292/github-page-shows-master-branch-not-gh-pages)
[github_pages_doc](https://docs.github.com/en/pages)