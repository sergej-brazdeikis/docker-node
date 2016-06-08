#!/bin/bash
set -eo pipefail

[ "$DEBUG" ] && set -x

# set current working directory to the directory of the script
cd "$(dirname "$0")"

dockerImage=$1

echo "Testing $dockerImage..."

if ! docker inspect "$dockerImage" &> /dev/null; then
    echo $'\timage does not exist!'
    false
fi

# running tests
cd node-sass
docker run -v $PWD:/src $dockerImage npm install || (echo "Npm install failed for node-sass package" && exit 1)
[ -d node_modules ] || (echo "node-sass package installation was not successful" && exit 1)
[ -e node_modules/node-sass/bin/node-sass ] || (echo "node-sass package installation binary does not exist" && exit 1)
cd ../

# testing volume owners
TEST_SSH_KEY_USER=`docker run -it -v $PWD/ssh:/home/1000/.ssh:ro sjevs/node stat -c "%U" /home/1000/.ssh/id_rsa`
TEST_SYSTEM_USER=`docker run -it -v $PWD/ssh:/home/1000/.ssh:ro sjevs/node whoami`
[ $TEST_SSH_KEY_USER = $TEST_SYSTEM_USER ] || (echo "System user does not match volume owner. It is critical for SSH keys" && exit 1)

# cleanup before other tests
rm -Rf node_modules

echo "SUCCESS"
