FROM python:3.10.8-bullseye

ARG SSH_PRIVATE_KEY

RUN apt update && \
    apt install -y tzdata npm && \
    apt autoremove -y && \
    git config --global user.name "TimHsu@DevContainer" && \
    git config --global user.email "maochindada@gmail.com" && \
    npm install -g n && n 18.14.0 && hash -r && \
    npm install -g commitizen && \
    npm install -g cz-conventional-changelog && \
    npm install -g conventional-changelog-cli && \
    echo '{ "path": "cz-conventional-changelog" }' > /root/.czrc

RUN mkdir /root/.ssh && \
    echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_ed25519 && \
    chmod 600 /root/.ssh/id_ed25519 && \
    touch /root/.ssh/known_hosts && \
    cat /root/.ssh/id_ed25519 && \
    ssh-keyscan github.com >> /root/.ssh/known_hosts

RUN mkdir /dev-share && \
    git clone git@github.com:ToC-Taiwan/toc-sinopac-python.git /toc-sinopac-python

ENV SJ_LOG_PATH=/toc-sinopac-python/logs/shioaji.log
ENV SJ_CONTRACTS_PATH=/toc-sinopac-python/data
WORKDIR /toc-sinopac-python
RUN make update
