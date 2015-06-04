Automatically compress videos from a given folder to a destination folder.

[![Build Status](https://travis-ci.org/rollbrettler/compress-videos.svg?branch=master)](https://travis-ci.org/rollbrettler/compress-videos)

## Build
```
rake build
```

## Build by hand

### Build ffmpeg
```
docker build -f build.Dockerfile -t="build" .
docker run -i -t --rm -v $(pwd)/build:/build build
```

### Build docker image
```
docker build -t="rollbrettler/compress-videos" .
```

## Execute docker container
```
docker run --rm -v ~/compress/_sort/videos:/source -v ~/compress/videos:/destination -v ~/compress/tmp:/tmp compress-videos
```

## Run tests

```
rake
```
