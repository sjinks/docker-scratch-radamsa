FROM debian:stable-slim@sha256:4d63ef53faef7bd35c92fbefb1e9e2e7b6777e3cbec6c34f640e96b925e430eb AS build

WORKDIR /build
RUN apt-get -qq update && apt-get -y --no-install-recommends install gcc libc6-dev wget ca-certificates
RUN wget -q https://gitlab.com/akihe/radamsa/uploads/d774a42f7893012d0a56c490a75ae12b/radamsa-0.7.c.gz -O radamsa.c.gz
RUN gzip -d radamsa.c.gz
RUN gcc -O2 --static radamsa.c -o radamsa
RUN strip radamsa

FROM scratch
COPY --from=build /build/radamsa /radamsa
ENTRYPOINT ["/radamsa"]
