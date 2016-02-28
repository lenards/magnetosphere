#!/bin/bash -x
set -eu
VAGRANT="/vagrant"
WORKSPACE="/vagrant/scratch"
GIT_BRANCH="master"
SERVER_NAME="localhost"
SECRETS="$WORKSPACE/atmo-extras/clank_init"
ENV_FILE="$SECRETS/build_env/variables.yml@vagrant"

# We only want to run this from within the context of a vagrant-box
WORKING_DIR="$(pwd)"

if [ "$WORKING_DIR" != "${WORKING_DIR/vagrant/}" ]; then
    echo "Let's rock the automation...";
else
    echo "Please execute from within vagrant box...";
    exit 5;
fi

# screw it - I'm writing functions...
create_if_does_not_exist() {
    if [ ! -d "$1" ]; then
        echo "making directory & chown-ing... ";
        sudo mkdir -p "$1";
        sudo chown vagrant:www-data -R "$1";
    fi
}

# Before running, ensure that `/vagrant` is present
# - if there isn't a `/vagrant` - someone might be
#   trying to run this from the host of the vm -
#   which is just a bag-of-hurt

#0. Begin, eh
cd "$VAGRANT"

# 0.1 - crimes against automation...
create_if_does_not_exist "$VAGRANT"
create_if_does_not_exist "$VAGRANT/dev/atmosphere"
create_if_does_not_exist "$VAGRANT/env/atmo"
create_if_does_not_exist "$VAGRANT/dev/troposphere"
create_if_does_not_exist "$VAGRANT/env/troposphere"
create_if_does_not_exist "$VAGRANT/dev/atmosphere-ansible"
create_if_does_not_exist "/opt/dev/"
create_if_does_not_exist "/opt/env/"

# ensure that canonical pathing existing within vagrant-box
ln -nfs $VAGRANT/dev/atmosphere /opt/dev/atmosphere
ln -nfs $VAGRANT/dev/troposphere /opt/dev/troposphere
ln -nfs $VAGRANT/dev/atmosphere-ansible /opt/dev/atmosphere-ansible

# move all of 0.1 into Clank at some __future___ date

# 0.5
#
# Clank defers to the Makefile of each project
# - no end-to-end testing has been done for
#   the self-signed certs
# - our bundled cert approach is not easily
#   undone - so adding an "empty" file to
#   make the `cat` succeed
cp "$SECRETS/empty_bundle.crt" /etc/ssl/certs/

#1. Clone repos - pre-flight handles this
# ensure `atmo-extras` in place
# ensure `clank` in place

#2. Prepare execution of ratchet
cd "$WORKSPACE"
virtualenv ratchet_env

#FIXME: This won't work on vagrant because `$PS1` is missing from env.
# . "$WORKSPACE/ratchet_env/bin/activate"

#FIXME: when the above is complete, remove the HACK below.
export PATH="/vagrant/scratch/ratchet_env/bin:$PATH"

cd "$WORKSPACE/clank"
pip install -r ./ratchet_requirements.txt

#3.0 ratchet args
RATCHET_ARGS="--workspace $WORKSPACE --env_file $ENV_FILE"
# Skip things:
# RATCHET_ARGS="$RATCHET_ARGS --skip 'dependencies,atmosphere'"
# Override branches
OVERRIDE_ARGS="{\"ATMOSPHERE_BRANCH\": \"$GIT_BRANCH\", \"TROPOSPHERE_BRANCH\": \"$GIT_BRANCH\"}"

#TODO: this wont work... need to bash-fu
#RATCHET_ARGS="$RATCHET_ARGS --override_args \"$OVERRIDE_ARGS\""

#3. Running ratchet
PYTHONUNBUFFERED=1 python ratchet.py $RATCHET_ARGS

#Cleanup: ensure that canonical `venv` are present within vagrant-box
ln -nfs  /vagrant/env/atmo /opt/env/atmo
ln -nfs  /vagrant/env/troposphere /opt/env/troposphere

