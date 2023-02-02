FROM python:3.10.8-bullseye
USER root

ARG SSH_PRIVATE_KEY

RUN groupadd -g 1000 docker-users && \
    useradd -m --no-log-init -s /bin/bash -u 1000 -g 1000 docker && \
    echo "docker:docker" | chpasswd && \
    adduser docker sudo

WORKDIR /
RUN apt update -y && \
    apt install -y tzdata npm && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    git config --global user.name "TimHsu@DevContainer" && \
    git config --global user.email "maochindada@gmail.com" && \
    mkdir dev-share

RUN pip install --upgrade pip
RUN npm install -g commitizen && \
    npm install -g cz-conventional-changelog && \
    npm install -g conventional-changelog-cli && \
    echo '{ "path": "cz-conventional-changelog" }' > /root/.czrc && \
    pip install --no-warn-script-location --no-cache-dir pre-commit

USER docker

RUN mkdir /home/docker/.ssh/ && \
    echo "${SSH_PRIVATE_KEY}" > /home/docker/.ssh/id_ed25519 && \
    chmod 600 /home/docker/.ssh/id_ed25519 && \
    touch /home/docker/.ssh/known_hosts && \
    cat /home/docker/.ssh/id_ed25519 && \
    ssh-keyscan github.com >> /home/docker/.ssh/known_hosts


# ENV PYLINTHOME=/toc-sinopac-python
# ENV PYTHONPATH=/toc-sinopac-python/pb
ENV SJ_LOG_PATH=/toc-sinopac-python/logs/shioaji.log
ENV SJ_CONTRACTS_PATH=/toc-sinopac-python/data

WORKDIR /home/docker
RUN git clone git@github.com:ToC-Taiwan/toc-sinopac-python.git /toc-sinopac-python
WORKDIR /home/docker/toc-sinopac-python

RUN pip install --no-warn-script-location --no-cache-dir -r requirements.txt
RUN ./scripts/install_dev_dependency.sh
