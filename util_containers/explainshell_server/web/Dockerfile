FROM python:alpine

RUN apk update \
    && apk add man-db \
        git \
        make \    
    && apk upgrade 

ADD ./requirements.txt /tmp/requirements.txt

RUN pip install --upgrade pip \
    && pip install -r /tmp/requirements.txt

# RUN git clone https://github.com/idank/explainshell.git
RUN git clone https://github.com/asimsharf/explainshell.git

RUN mv ./explainshell /opt/webapp

WORKDIR /opt/webapp
EXPOSE 5000

CMD [ "make", "serve" ]
