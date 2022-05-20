# TOC SINOPAC PYTHON DEV

## Run Container Command

```sh
docker stop toc-sinopac-python
docker rmi -f $(docker images -a -q) && docker system prune --volumes -f
docker run -dt --name toc-sinopac-python \
    --restart=always \
    -p 6666:6666 \
    -e TZ="Asia/Taipei" \
    -v /Users/timhsu/dev_projects/python/toc-sinopac-python-container:/dev-share \
    gitlab.tocraw.com:5050/root/toc-sinopac-python:latest
```