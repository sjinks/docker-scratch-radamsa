FROM debian:stable-slim@sha256:46319ede638871d01264e356b55723f28c2769674966475240ca9c0cbd7f9cfb AS build

WORKDIR /build
RUN apt-get -qq update && apt-get -y --no-install-recommends install gcc libc6-dev wget ca-certificates
RUN wget -q https://gitlab.com/akihe/radamsa/uploads/a2228910d0d3c68d19c09cee3943d7e5/radamsa-0.6.c.gz -O radamsa.c.gz
RUN gzip -d radamsa.c.gz
RUN gcc -O2 --static radamsa.c -o radamsa
RUN strip radamsa

FROM scratch
COPY --from=build /build/radamsa /radamsa
ENTRYPOINT ["/radamsa"]
