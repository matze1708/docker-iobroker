FROM debian:latest

MAINTAINER Andre Germann <info@buanet.de>

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update && apt-get install -y apt-utils curl avahi-daemon
RUN curl -sL https://deb.nodesource.com/setup_4.x | bash
RUN apt-get install -y build-essential python nodejs

RUN mkdir -p /opt/iobroker/ && chmod 777 /opt/iobroker/

WORKDIR /opt/iobroker/

RUN npm install iobroker --unsafe-perm && echo $(hostname) > .install_host

ADD scripts/startup.sh startup.sh
ADD scripts/avahi-start.sh avahi-start.sh
RUN chmod +x startup.sh avahi-start.sh
RUN mkdir /var/run/dbus/

CMD ["sh", "/opt/iobroker/startup.sh"]

ENV DEBIAN_FRONTEND teletype
