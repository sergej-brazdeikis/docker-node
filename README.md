# sjevs/node

This Docker image contains `node` and `npm`. It is based on [Debian from Google](https://hub.docker.com/r/google/debian/)

## Features
* Supports private Git repositories
* Non-root execution
* boosted via shared `.npm` folder - actually just at tip here ;)
* Minimal size [Latest build](https://hub.docker.com/r/sjevs/node/tags/) is `138 MB`. [Official node](https://hub.docker.com/r/library/node/tags/) - `190 MB`

## Usage

```
docker run -it --rm -v $PWD:/src -v $HOME/.ssh:/home/1000/.ssh -v $HOME/.npm:/home/1000/.npm sjevs/node npm install
```

## Story behind it

[Blogpost](http://docker-blog.jevsejev.io/2016/06/08/docker-minimal-image-with-private-git-repositories/) about this repository
