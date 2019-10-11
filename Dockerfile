# =============================
# Builder (golang binaries):
# =============================
FROM golang AS build1
RUN apt-get update && apt-get install --no-install-recommends --yes git
RUN go get -u github.com/rakyll/hey

# =============================
# Primary image
# =============================
FROM ubuntu:bionic

RUN apt-get update \
  && apt-get install --no-install-recommends --yes \
    bind9-host \
    curl \
    dnsutils \
    iputils-ping \
    jq \
    linux-tools-generic \
    locales \
    nano \
    net-tools \
    netcat-openbsd \
    openssh-client \
    parallel \
    python-pip \
    python-setuptools \
    swaks \
    telnet \
    vim \
    wget \
    && locale-gen en_US.UTF-8

# HTTP Load-Test Tools: 
# -----------------------------
COPY --from=build1 /go/bin/hey /usr/local/bin/hey
RUN apt-get update \
  && apt-get install --no-install-recommends --yes \
    apache2-utils \
    httpie \
    siege

# DB/MQ TOOLS:
# -----------------------------
RUN apt-get install --no-install-recommends --yes \
    influxdb-client \
    mongodb-clients \
    mysql-client \
    postgresql-client \
    rabbitmq-server \
    redis-tools

RUN curl -O https://raw.githubusercontent.com/rabbitmq/rabbitmq-management/v3.7.14/bin/rabbitmqadmin \
  && mv rabbitmqadmin /usr/local/bin/ \
  && chmod +x /usr/local/bin/rabbitmqadmin

# Cassandra CQL Shell: 
RUN pip install cqlsh



# # GCLOUD & KUBECTL:
# # -----------------------------
# RUN curl -sSL https://sdk.cloud.google.com | bash
# ENV PATH $PATH:/root/google-cloud-sdk/bin

# # configure gcloud & kubectl
# RUN gcloud config set core/disable_usage_reporting true && \
#     gcloud config set component_manager/disable_update_check true \
#     gcloud --quiet components update; \
#     gcloud components install alpha beta kubectl --quiet


ENV TERM=xterm
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8