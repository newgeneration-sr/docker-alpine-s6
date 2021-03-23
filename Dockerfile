FROM alpine:latest

ENV S6_OVERLAY_VERSION=v2.1.0.2

ENV MUSL_LOCPATH="/usr/share/i18n/locales/musl"
ENV LC_ALL=fr_FR.UTF-8

RUN apk add curl musl-locales musl-locales-lang \
    && curl -s -L https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz --output ./s6-overlay-amd64.tar.gz  \
    && tar xfz s6-overlay-amd64.tar.gz -C / \
    && mkdir -p /var/run/s6 \
    && rm s6-overlay-amd64.tar.gz 
ADD conf/ /

RUN chmod +x /usr/bin/service-handler \
    && chmod +x /etc/cont-init.d/ -R \
    && chmod +x /etc/periodic/ -R  \
    && chmod +x /etc/s6/services/ -R 

ENTRYPOINT ["/init"]
