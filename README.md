# docker-xpra-html5


This docker image provides remote access using [xpra](https://xpra.org/) to an xterm via a HTML5 based web client listening on port 14500 for websocket connections.

A container using the image can be started with e.g. and it will launch xterm by default

```sh
docker run -p 14500:14500 ffeldhaus/docker-xpra-html5
```

Then open a browser with the hostname or IP of your docker host:

https://\<hostname OR IP>:14500