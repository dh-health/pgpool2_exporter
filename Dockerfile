# Build the manager binary
FROM golang:1.14 as builder

WORKDIR /go/src/github.com/pgpool/pgpool2_exporter
# Ensure prometheus binaries
RUN GO111MODULE=off go get github.com/prometheus/promu

# Copy the go source
COPY . .

# Build
RUN make

FROM quay.io/prometheus/busybox:latest

COPY --from=builder /go/src/github.com/pgpool/pgpool2_exporter/pgpool2_exporter /bin/pgpool2_exporter

ENTRYPOINT ["/bin/pgpool2_exporter"]
EXPOSE     9719
