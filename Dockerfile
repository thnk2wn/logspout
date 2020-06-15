FROM golang:1.14.4-buster
ENTRYPOINT ["/bin/logspout"]
VOLUME /mnt/routes
EXPOSE 80

RUN pwd
RUN ls -a
COPY . /src
RUN cd /src
RUN pwd
RUN ls -a
RUN chmod +x ./build.sh
RUN ./build.sh "$(cat VERSION)"

ONBUILD COPY ./build.sh /src/build.sh
ONBUILD COPY ./modules.go /src/modules.go
ONBUILD RUN cd /src && chmod +x ./build.sh && sleep 1 && sync && ./build.sh "$(cat VERSION)-custom"
