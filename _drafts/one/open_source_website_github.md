# O_S_website

[bootstrap](https://github.com/twbs/bootstrap) [wordpress](https://github.com/WordPress/WordPress) [jekyII](https://github.com/jekyll/jekyll) [ghost ](https://github.com/TryGhost/Ghost) [hugo](https://github.com/gohugoio/hugo)

# Jekyll:

## ruby installation

[ruby_installation_docs](https://www.ruby-lang.org/en/documentation/installation/)

```bash
ruby -v
sudo apt-get install ruby-full (gem included probably)
```

also see the [jekyll_ubuntu_installation_docs](https://jekyllrb.com/docs/installation/ubuntu/)

## jekyll installation

 [jekyllrb.com](https://jekyllrb.com/) 

```bash
gem install bundler jekyll
```

#### the gem sources stuff

```bash
gem source
gem source -a https://rubygems.org/gems
gem update --system
```

#### generate a new site

```bash
jekyll new testsite
cd testsite
bundle exec jekyll serve
# => Now browse to http://localhost:4000
```

#### use a template or jekyll theme

####  [chripy_theme](https://github.com/cotes2020/chirpy-starter)

create a repo using the template [chirpy](https://github.com/cotes2020/chirpy-starter/generate)

```bash
#clone the repo cd the repo and ...
bundle
bundle exec jekyll s
# => Now browse to http://localhost:4000
```

[chirpy_docs ](https://chirpy.cotes.page/) [jekyll_post_docs](https://jekyllrb.com/docs/posts/)

#### set the _config.yml

**add content to _post**

delete the .placeholder 

name the md file like `2023-4-12-test.md`

add the right yaml front matter like below

```bash
---
layout: "post"
title: "test"
date: 2023-4-12
categories: first second
tags: one two three
---
```



cdn? content delivery network

cors?cross origin resource sharing
