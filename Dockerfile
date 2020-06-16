FROM golang:1.14.4-buster
ENTRYPOINT ["/bin/logspout"]
VOLUME /mnt/routes
EXPOSE 80

COPY qemu-arm-static /usr/bin/qemu-arm-static

COPY . /src
RUN ls -a /src

RUN cd /src && chmod +x ./build.sh && ./build.sh "$(cat VERSION)"

# For any images derived from this one
ONBUILD COPY ./build.sh /src/build.sh
ONBUILD COPY ./modules.go /src/modules.go
ONBUILD RUN cd /src && chmod +x ./build.sh && sleep 1 && sync && ./build.sh "$(cat VERSION)-custom"