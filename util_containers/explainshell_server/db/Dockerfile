FROM mongo

RUN apt-get update -y \
    && apt-get install curl -y \
    && apt-get upgrade -y

RUN curl -L -o /tmp/dump.gz https://github.com/idank/explainshell/releases/download/db-dump/dump.gz
RUN mongorestore /tmp/dump
