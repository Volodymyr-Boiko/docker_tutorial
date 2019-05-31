FROM python:3.6-alpine3.6

RUN apk add --update build-base python3-dev py-pip postgresql-dev openldap-dev

ADD . /app

WORKDIR /app

COPY requirements.txt ./app

RUN pip install -r requirements.txt

EXPOSE 8000
