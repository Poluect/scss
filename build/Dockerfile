FROM golang:latest

RUN mkdir /app
ADD . /app/
WORKDIR /app/src
RUN go build -o /app/app .
CMD ["/app/app"]