---
categories: w default
tags: [git]
---

## remote
```bash
git remote -v #==> list the remote source information
git remote remove origin #==> remove the origin remote settings
git remote add origin git@github.com:username/reponame.git #==> add remote source using ssh URL
git remote set-url origin git@github.com:username/reponame.git #==> update remote source
```

## branch
```bash
git branch -a #==> list all branches
git branch -D branchname #==> delete a branch
git branch -M main #==> rename current branch to main
git branch branchname #==> create a new branch based on the current branch
git checkout branchname #==> change to another branch
git push -u origin branchname #==> push to certain remote branch
```

## clone
```bash
git clone https://github.com/username/reponame.git` #==> use https URL
git clone git@github.com:oodenough/moviesmatter.git` #==> use ssh URL
```