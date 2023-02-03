# TOC SINOPAC PYTHON DEV

## Run Container Command

```sh
docker stop toc-rabbitmq
docker stop toc-sinopac-python-dev
docker system prune --volumes -f
docker rmi -f $(docker images -a -q)

docker run -d \
  --restart always \
  --name toc-rabbitmq \
  -p 5672:5672 \
  -p 15672:15672 \
  -e RABBITMQ_DEFAULT_USER=admin \
  -e RABBITMQ_DEFAULT_PASS=password \
  rabbitmq:3.11.5-management

docker run -dt --name toc-sinopac-python-dev \
    --restart=always \
    --link toc-rabbitmq:toc-rabbitmq \
    -p 56666:56666 \
    -e TZ="Asia/Taipei" \
    -v $(pwd)/dev-share:/dev-share \
    maochindada/toc-sinopac-python-dev:latest
```
