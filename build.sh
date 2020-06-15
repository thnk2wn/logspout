set -e

echo "Adding packages"
#apk add -v --update go build-base git mercurial ca-certificates
apt-get install git mercurial ca-certificates

echo "Switching to src dir"
cd /src

echo "Running Go build"
go build -ldflags "-X main.Version=$1" -o /bin/logspout

echo "Deleting packages"
#apk del go git mercurial build-base
apt-get remove git mercurial

echo "Cleaning up"
rm -rf /root/go /var/cache/apk/*

# backwards compatibility
echo "Docker symbolic link"
ln -fs /tmp/docker.sock /var/run/docker.sock
