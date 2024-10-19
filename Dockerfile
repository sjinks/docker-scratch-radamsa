FROM debian:stable-slim@sha256:fffe16098bcefa876d01862a61f8f30ef4292c9485940e905d41a15d8459828b AS build

WORKDIR /build
RUN apt-get -qq update && apt-get -y --no-install-recommends install gcc libc6-dev wget ca-certificates
RUN wget -q https://gitlab.com/akihe/radamsa/uploads/d774a42f7893012d0a56c490a75ae12b/radamsa-0.7.c.gz -O radamsa.c.gz
RUN gzip -d radamsa.c.gz
RUN gcc -O2 --static radamsa.c -o radamsa
RUN strip radamsa

FROM scratch
COPY --from=build /build/radamsa /radamsa
ENTRYPOINT ["/radamsa"]
