FROM python:3.7.13-bullseye
USER root

ARG SSH_PRIVATE_KEY
WORKDIR /
RUN apt update -y && \
    apt install -y tzdata && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    git config --global user.name "TimHsu@DevContainer" && \
    git config --global user.email "maochindada@gmail.com" && \
    mkdir dev-share

RUN mkdir /root/.ssh/ && \
    echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_ed25519 && \
    chmod 600 /root/.ssh/id_ed25519 && \
    touch /root/.ssh/known_hosts && \
    ssh-keyscan gitlab.tocraw.com >> /root/.ssh/known_hosts

WORKDIR /utils
RUN curl -fSL https://github.com/protocolbuffers/protobuf/releases/download/v3.20.1/protoc-3.20.1-linux-x86_64.zip --output protobuf.zip && \
    unzip protobuf.zip -d protobuf

ENV TZ=Asia/Taipei
ENV PATH="$PATH:/utils/protobuf/bin"
ENV PYLINTHOME=/toc-sinopac-python

WORKDIR /
RUN git clone git@gitlab.tocraw.com:root/toc-sinopac-python.git /toc-sinopac-python
WORKDIR /toc-sinopac-python
# RUN pip install --no-warn-script-location --no-cache-dir -r requirements.txt
# RUN mypy --config-file=./mypy.ini ./src/main.py ./src/mq_topic.py
