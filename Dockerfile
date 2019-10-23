FROM alpine:latest


RUN set -x \
    && apk add curl \
    && export S6_OVERLAY_VERSION=$(curl -s -L https://api.github.com/repos/just-containers/s6-overlay/releases/latest | grep "tag_name" | cut -d "\"" -f4 )  \
    && curl -s -L https://github.com/just-containers/s6-overlay/releases/download/${S6_OVERLAY_VERSION}/s6-overlay-amd64.tar.gz --output ./s6-overlay-amd64.tar.gz  \
    && tar xfz s6-overlay-amd64.tar.gz -C / \
    && mkdir -p /var/run/s6 \
    && rm s6-overlay-amd64.tar.gz 
ADD conf/ /

RUN set -x \
    && chmod +x /usr/bin/service-handler \
    && chmod +x /etc/cont-init.d/ -R \
    && chmod +x /etc/periodic/ -R  \
    && chmod +x /etc/s6/services/ -R 

ENTRYPOINT ["/init"]