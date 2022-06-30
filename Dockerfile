FROM python:3.10.5-bullseye
USER root

ARG SSH_PRIVATE_KEY
WORKDIR /
RUN apt update -y && \
    apt install -y tzdata npm && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /var/lib/apt/lists/* && \
    git config --global user.name "TimHsu@DevContainer" && \
    git config --global user.email "maochindada@gmail.com" && \
    mkdir dev-share


RUN npm install -g commitizen && \
    npm install -g cz-conventional-changelog && \
    npm install -g conventional-changelog-cli && \
    echo '{ "path": "cz-conventional-changelog" }' > /root/.czrc && \
    pip install --no-warn-script-location --no-cache-dir pre-commit


RUN mkdir /root/.ssh/ && \
    echo "${SSH_PRIVATE_KEY}" > /root/.ssh/id_ed25519 && \
    chmod 600 /root/.ssh/id_ed25519 && \
    touch /root/.ssh/known_hosts && \
    ssh-keyscan gitlab.tocraw.com >> /root/.ssh/known_hosts


ENV PYLINTHOME=/toc-sinopac-python
ENV SJ_LOG_PATH=/toc-sinopac-python/logs/shioaji.log
ENV SJ_CONTRACTS_PATH=/toc-sinopac-python/data


WORKDIR /
RUN git clone git@gitlab.tocraw.com:root/toc-sinopac-python.git /toc-sinopac-python
WORKDIR /toc-sinopac-python
# RUN pip install --no-warn-script-location --no-cache-dir -r requirements.txt
# RUN mypy --config-file=./mypy.ini ./src/main.py ./src/mq_topic.py
