FROM ffeldhaus/docker-xpra-minimal

LABEL version="0.5"
LABEL maintainer="florian.feldhaus@gmail.com"

# skip interactive configuration dialogs
ENV DEBIAN_FRONTEND noninteractive

# add winswitch repository and install Xpra
RUN apt-get update && \
    apt-get install -y --no-install-recommends xpra-html5 && \
    rm -rf /var/lib/apt/lists/*

# copy xpra config file
COPY ./xpra.conf /etc/xpra/xpra.conf

# expose xpra HTML5 client port
EXPOSE 14500

# use docker-entrypoint.sh to allow passing options to xpra and start xpra from bash
COPY docker-entrypoint.sh /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# run xterm by default
CMD ["xterm"]