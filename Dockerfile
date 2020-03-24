FROM ewbankkit/rust-amazonlinux:1.41.1-2018.03.0.20191219.0 AS builder

WORKDIR /usr/src/gantry
COPY gantry .
RUN cargo install --path server

WORKDIR /usr/src/nats-provider
COPY nats-provider .
RUN cargo build --release

WORKDIR /usr/src/redis-provider
COPY redis-provider .
RUN cargo build --release

WORKDIR /usr/src/s3-provider
COPY s3-provider .
RUN cargo build --release

FROM amazonlinux:2018.03.0.20191219.0
LABEL maintainer="Kit_Ewbank@hotmail.com"

COPY --from=builder /usr/local/cargo/bin/gantry-server /app/gantry-server
COPY --from=builder /usr/src/nats-provider/target/release/libnats_provider.so /app/libnats_provider.so
COPY --from=builder /usr/src/redis-provider/target/release/libredis_provider.so /app/libredis_provider.so
COPY --from=builder /usr/src/s3-provider/target/release/libs3_provider.so /app/libs3_provider.so

ENTRYPOINT ["/app/gantry-server"]
