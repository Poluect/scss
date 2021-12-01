FROM golang:latest as build

RUN mkdir /app
ADD . /app/
WORKDIR /app/src
RUN make build

FROM alpine:3.14.2 as certs
RUN apk update && apk add ca-certificates

FROM gcr.io/distroless/base
COPY --from=certs /etc/ssl/certs /etc/ssl/certs
COPY --from=build /app/src/bin/sscs /usr/local/bin/sscs
# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["sscs"]