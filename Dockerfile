FROM golang:1.20-alpine
WORKDIR /usr/src/app
COPY go.mod ./
RUN go mod download && go mod verify
COPY hello.go .
RUN CGO_ENABLED=0 GOOS=linux go build -a -installsuffix cgo -o app .

FROM scratch
WORKDIR /root/
COPY --from=0 /usr/src/app .
CMD ["./app"]