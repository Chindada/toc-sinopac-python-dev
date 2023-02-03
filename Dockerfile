FROM python:3.10.8-bullseye

ARG SSH_PRIVATE_KEY

RUN apt update && \
    apt install -y tzdata npm sudo && \
    apt autoremove -y && \
    git config --global user.name "TimHsu@DevContainer" && \
    git config --global user.email "maochindada@gmail.com" && \
    npm install -g n && n 18.14.0 && hash -r && \
    npm install -g commitizen && \
    npm install -g cz-conventional-changelog && \
    npm install -g conventional-changelog-cli

RUN groupadd -g 1000 docker-users && \
    useradd -m --no-log-init -s /bin/bash -u 1000 -g 1000 docker && \
    echo "docker:docker" | chpasswd && \
    adduser docker sudo

USER docker
ENV HOME=/home/docker

ENV SJ_LOG_PATH=$HOME/toc-sinopac-python/logs/shioaji.log
ENV SJ_CONTRACTS_PATH=$HOME/toc-sinopac-python/data

RUN mkdir $HOME/.ssh && \
    echo "${SSH_PRIVATE_KEY}" > $HOME/.ssh/id_ed25519 && \
    chmod 600 $HOME/.ssh/id_ed25519 && \
    touch $HOME/.ssh/known_hosts && \
    cat $HOME/.ssh/id_ed25519 && \
    ssh-keyscan github.com >> $HOME/.ssh/known_hosts && \
    echo '{ "path": "cz-conventional-changelog" }' > $HOME/.czrc

RUN mkdir $HOME/dev-share && \
    git clone git@github.com:ToC-Taiwan/toc-sinopac-python.git $HOME/toc-sinopac-python

RUN python -m venv $HOME/toc-sinopac-python
ENV PATH="$HOME/toc-sinopac-python/bin:$PATH"

WORKDIR $HOME/toc-sinopac-python
RUN make update
