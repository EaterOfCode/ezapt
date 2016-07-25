FROM ubuntu:16.04
RUN \
    apt-get update; \
    apt-get upgrade -y; \
    apt-get install -y wget git ruby build-essential; \
    mkdir /source; \
    mkdir /result; \
    mkdir /ezapt;

ENV HOME /ezapt
WORKDIR /ezapt
VOLUME /result
VOLUME /ezapt

CMD ["bash"]