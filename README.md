# TOC SINOPAC PYTHON DEV

## Run Container Command

```sh
docker stop toc-sinopac-python-dev
docker system prune --volumes -f
docker rmi -f $(docker images -a -q)
docker run -dt --name toc-sinopac-python-dev \
    --restart=always \
    -p 56666:56666 \
    -e TZ="Asia/Taipei" \
    -v $(pwd)/dev-share:/dev-share \
    maochindada/toc-sinopac-python-dev:latest
```
