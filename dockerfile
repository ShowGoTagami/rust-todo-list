FROM rust:1.43 AS builder

WORKDIR /rust-todo-list

COPY Cargo.toml Cargo.toml
RUN mkdir src
RUN echo "fn main(){}" > src/main.rs
RUN cargo build --release
COPY ./src ./src
COPY ./templates ./templates

RUN rm -f target/release/deps/rust-todo-list*

RUN cargo build --release

FROM debian:10.4

COPY --from=builder /rust-todo-list/target/release/rust-todo-list /usr/local/bin/rust-todo-list

CMD ["rust-todo-list"]
