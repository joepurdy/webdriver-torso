FROM alpine:latest

RUN apk add sox ffmpeg imagemagick
RUN wget -P /tmp https://noto-website-2.storage.googleapis.com/pkgs/NotoMono-hinted.zip; \
    unzip /tmp/NotoMono-hinted.zip -d /usr/share/fonts/

RUN mkdir -p /opt/wdt/process /opt/wdt/video

WORKDIR /opt/wdt/

ADD webdriver-torso.sh .

ENTRYPOINT [ "./webdriver-torso.sh" ]
