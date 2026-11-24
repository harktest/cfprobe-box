FROM alpine:3.20
ARG TARGETARCH=amd64
RUN apk add --no-cache ca-certificates busybox-extras \
 && wget -qO /usr/local/bin/cf-probe https://github.com/huilang-me/cfsm-agent/releases/download/v1.1.4/cf-probe-linux-${TARGETARCH:-amd64} \
 && chmod +x /usr/local/bin/cf-probe
COPY start.sh /start.sh
RUN chmod +x /start.sh
EXPOSE 8080
CMD ["/start.sh"]
