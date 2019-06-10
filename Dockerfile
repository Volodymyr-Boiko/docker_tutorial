FROM ubuntu:bionic

RUN mkdir app

RUN apt-get -qq -y update && apt-get -y install python3-dev python3-pip libpq-dev && pip3 install virtualenv

ADD . /app

WORKDIR /app

RUN pip3 install --upgrade setuptools

RUN virtualenv venv

RUN groupadd -g 2000 newuser && useradd -m -u 2001 -g newuser newuser

USER newuser

RUN . venv/bin/activate

ADD requirements.txt ./app

RUN pip3 install -r requirements.txt

EXPOSE 8000
