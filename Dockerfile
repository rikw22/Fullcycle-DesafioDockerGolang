FROM golang:1.21.5-bookworm AS builder

WORKDIR /usr/src/app
COPY go.mod ./
RUN go mod download && go mod verify
COPY . .
RUN go build -ldflags="-s -w" -v -o /usr/src/app/app ./...


FROM scratch
COPY --from=builder /usr/src/app/app /usr/src/app/app


CMD ["/usr/src/app/app"]