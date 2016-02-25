WORKSPACE="/vagrant"
GIT_BRANCH="master"
SERVER_NAME="localhost"
SECRETS="$WORKSPACE/atmo-extras/clank_init/"
ENV_FILE="$WORKSPACE/atmo-extras/clank_init/build_env/variables.yml@vagrant"


# screw it - I'm writing functions...
create_if_does_not_exist() {
    if [ ! -d "$1" ]; then
        echo "making directory & chown-ing... ";
        sudo mkdir -p "$1";
        sudo chown vagrant:vagrant -R "$1";
    fi
}

# Before running, ensure that `/vagrant` is present
# - if there isn't a `/vagrant` - someone might be
#   trying to run this from the host of the vm -
#   which is just a bag-of-hurt

#0. Begin, eh
cd "$WORKSPACE"

create_if_does_not_exist "/opt/dev/atmosphere"
create_if_does_not_exist "/opt/env/atmo"

# 0.5
#
# Clank defers to the Makefile of each project
# - no end-to-end testing has been done for
#   the self-signed certs
# - our bundled cert approach is not easily
#   undone - so adding an "empty" file to
#   make the `cat` succeed
cp $SECRETS"empty_bundle.crt" /etc/ssl/certs/

#1. Clone repos - pre-flight handles this
# ensure `atmo-extras` in place
# ensure `clank` in place

#2. Prepare execution of ratchet
virtualenv ratchet_env
. ratchet_env/bin/activate
pip install -r clank/ratchet_requirements.txt

#3. Running ratchet
cd "$WORKSPACE/clank"
PYTHONUNBUFFERED=1 python ratchet.py --workspace $WORKSPACE --env_file $ENV_FILE

#4. Chown to vagrant, activate and run!
cd "$WORKSPACE"
sudo chown -R vagrant:vagrant .
cd "/opt/dev/atmosphere"
. "/opt/env/atmo/bin/activate"

