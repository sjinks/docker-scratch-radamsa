FROM debian:stable-slim@sha256:d10f0545d14bad5f4d230301f7e4fd904384f2dd16fda16d708f936c2fa1db3e AS build

WORKDIR /build
RUN apt-get -qq update && apt-get -y --no-install-recommends install gcc libc6-dev wget ca-certificates
RUN wget -q https://gitlab.com/akihe/radamsa/uploads/a2228910d0d3c68d19c09cee3943d7e5/radamsa-0.6.c.gz -O radamsa.c.gz
RUN gzip -d radamsa.c.gz
RUN gcc -O2 --static radamsa.c -o radamsa
RUN strip radamsa

FROM scratch
COPY --from=build /build/radamsa /radamsa
ENTRYPOINT ["/radamsa"]
