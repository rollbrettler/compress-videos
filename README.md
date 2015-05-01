

### Build image
```
docker build -t="rollbrettler/convert-video" .
```

## Execute docker container
```
docker run --rm -v ~/convert/_sort/videos:/source -v ~/convert/videos:/destination -v ~/convert/tmp:/tmp convert-videos
```
