FROM alpine:3
RUN apk add smartmontools
COPY ./smartctl_exporter /bin/smartctl_exporter
EXPOSE 9633
USER nobody
ENTRYPOINT [ "/bin/smartctl_exporter" ]
