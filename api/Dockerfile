FROM python:3.9-slim-buster

RUN apt-get update \
  && apt-get install -y --no-install-recommends \
  build-essential \
  && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /opt/myproject/api
ADD ./requirements.txt /opt/myproject/api
WORKDIR /opt/myproject/api
RUN pip install -r requirements.txt
ADD . /opt/myproject/api
WORKDIR /opt/myproject/api/src
