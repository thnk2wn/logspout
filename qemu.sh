apt-get update && apt-get install -y --no-install-recommends qemu-user-static binfmt-support
update-binfmts --enable qemu-arm
update-binfmts --display qemu-arm

mount binfmt_misc -t binfmt_misc /proc/sys/fs/binfmt_misc
echo ':arm:M::\x7fELF\x01\x01\x01\x00\x00\x00\x00\x00\x00\x00\x00\x00\x02\x00\x28\x00:\xff\xff\xff\xff\xff\xff\xff\x00\xff\xff\xff\xff\xff\xff\xff\xff\xfe\xff\xff\xff:/usr/bin/qemu-arm-static:' > /proc/sys/fs/binfmt_misc/register

cp -v /usr/bin/qemu-arm-static .