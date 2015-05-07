Automatically convert videos from a given folder to a destination folder.

### Build image
```
docker build -f build-ffmpeg.Dockerfile -t="build-ffmpeg" .
docker run -i -t --rm -v $(pwd)/build:/build build-ffmpeg
```


### Build docker image
```
docker build -t="rollbrettler/convert-videos" .
```

### Execute docker container
```
docker run --rm -v ~/convert/_sort/videos:/source -v ~/convert/videos:/destination -v ~/convert/tmp:/tmp convert-videos
```
