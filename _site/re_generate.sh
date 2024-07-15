#!/bin/bash
docker image rm my_blog
docker build -t my_blog .
docker run --rm -v $(pwd):/work -p 8080:4000 my_blog