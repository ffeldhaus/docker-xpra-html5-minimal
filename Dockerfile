FROM ubuntu:20.04

LABEL version="0.3"
LABEL maintainer="florian.feldhaus@gmail.com"

# skip interactive configuration dialogs
ENV DEBIAN_FRONTEND noninteractive

# add winswitch repository and install Xpra
RUN apt-get update && \
    apt-get install -y gnupg curl software-properties-common && \
    curl http://xpra.org/gpg.asc | apt-key add - && \
    echo "deb http://xpra.org/ focal main" >> /etc/apt/sources.list.d/xpra.list && \
    apt-get update && \
    apt-get install -y xpra python-pyinotify libvpx6 && \
    apt-get remove -y --purge gnupg curl software-properties-common && \
    rm -rf /var/lib/apt/lists/*

# copy xpra config file
COPY ./xpra.conf /etc/xpra/xpra.conf

# allow users to read default certificate
RUN chmod 644 /etc/xpra/ssl-cert.pem

# add xpra user
RUN useradd --create-home --shell /bin/bash xpra --gid xpra --uid 1000
WORKDIR /home/xpra

# create run directory for xpra socket and set correct permissions for xpra user
RUN mkdir -p /run/user/1000/xpra && chown -R 1000 /run/user/1000

# expose xpra HTML5 client port
EXPOSE 14500

# use docker-entrypoint.sh to allow passing options to xpra and start xpra from bash
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# change to user xpra
USER xpra

# run xterm by default
CMD ["xterm"]
