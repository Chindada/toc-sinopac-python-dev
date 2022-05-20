# TOC SINOPAC PYTHON DEV

## Run Container Command

```sh
docker stop toc-sinopac-python-dev
docker rmi -f $(docker images -a -q) && docker system prune --volumes -f
docker run -dt --name toc-sinopac-python-dev \
    --restart=always \
    -p 6666:6666 \
    -e TZ="Asia/Taipei" \
    -v /Users/timhsu/dev_projects/python/toc-sinopac-python-share:/dev-share \
    gitlab.tocraw.com:5050/root/toc-sinopac-python-dev:latest
```
