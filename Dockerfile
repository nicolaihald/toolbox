FROM ubuntu:bionic

RUN apt-get update \
  && apt-get install --no-install-recommends --yes \
    apache2-utils \
    bind9-host \
    curl \
    dnsutils \
    httpie \
    influxdb-client \
    iputils-ping \
    jq \
    linux-tools-generic \
    locales \
    mongodb-clients \
    mysql-client \
    nano \
    net-tools \
    netcat-openbsd \
    openssh-client \
    parallel \
    postgresql-client \
    python-pip \
    python-setuptools \
    rabbitmq-server \
    redis-tools \
    swaks \
    siege \
    telnet \
    vim \
    wget

RUN curl -O https://raw.githubusercontent.com/rabbitmq/rabbitmq-management/v3.7.14/bin/rabbitmqadmin \
  && mv rabbitmqadmin /usr/local/bin/ \
  && chmod +x /usr/local/bin/rabbitmqadmin

RUN pip install cqlsh

RUN locale-gen en_US.UTF-8

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8