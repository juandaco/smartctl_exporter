FROM golang:1.24 AS builder
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY ./ ./
RUN CGO_ENABLED=0 GOOS=linux go build -o smartctl_exporter

FROM alpine:3 AS runner
RUN apk add smartmontools
COPY --from=builder /build/smartctl_exporter /bin/smartctl_exporter
EXPOSE 9633
USER nobody
ENTRYPOINT [ "/bin/smartctl_exporter" ]
