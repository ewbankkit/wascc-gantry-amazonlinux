FROM ewbankkit/rust-amazonlinux:1.41.1-2018.03.0.20191219.0 AS builder

WORKDIR /usr/src/gantry
COPY gantry .
RUN cargo install --path server

FROM amazonlinux:2018.03.0.20191219.0
LABEL maintainer="Kit_Ewbank@hotmail.com"

COPY --from=builder /usr/local/cargo/bin/gantry-server /usr/local/bin/gantry-server

CMD ["/usr/local/bin/gantry-server"]
