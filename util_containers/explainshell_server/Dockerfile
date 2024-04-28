FROM python:alpine

RUN apk update \
    && apk add man-db \
        git \
        curl \
        make \    
    && apk upgrade 

ADD ./requirements.txt /tmp/requirements.txt

RUN pip install --upgrade pip \
    && pip install -r /tmp/requirements.txt

RUN curl -L -o /tmp/dump.gz https://github.com/idank/explainshell/releases/download/db-dump/dump.gz

# RUN git clone https://github.com/idank/explainshell.git
RUN git clone https://github.com/asimsharf/explainshell.git
RUN mv ./explainshell /opt/webapp

WORKDIR /opt/webapp
EXPOSE 5000

CMD [ "make", "serve" ]
