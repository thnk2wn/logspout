#!/bin/sh
set -e

echo "Go get"
go get -v -t -d ./...

if [ -f Gopkg.toml ]; then
    echo "Installing Go dependency manager"
    curl https://raw.githubusercontent.com/golang/dep/master/install.sh | sh

    echo "Ensuring dependencies"
    dep ensure
fi

echo "Adding packages"
apk add -v --update go build-base git mercurial ca-certificates

echo "Switching to src dir"
cd /src

echo "Running Go build"
go build -ldflags "-X main.Version=$1" -o /bin/logspout

echo "Deleting packages"
apk del go git mercurial build-base

echo "Cleaning up"
rm -rf /root/go /var/cache/apk/*

# backwards compatibility
echo "Docker symbolic link"
ln -fs /tmp/docker.sock /var/run/docker.sock
