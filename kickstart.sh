WORKSPACE="/vagrant/scratch"
GIT_BRANCH="master"
SERVER_NAME="localhost"
SECRETS="$WORKSPACE/atmo-extras/clank_init/"
ENV_FILE="$WORKSPACE/atmo-extras/clank_init/build_env/variables.yml@vagrant"

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
cd "$WORKSPACE"

# 0.1 - crimes against automation...
create_if_does_not_exist "/vagrant/scratch"
create_if_does_not_exist "/vagrant/dev/atmosphere"
create_if_does_not_exist "/vagrant/env/atmo"
create_if_does_not_exist "/vagrant/dev/troposphere"
create_if_does_not_exist "/vagrant/env/troposphere"
create_if_does_not_exist "/vagrant/dev/atmosphere-ansible"

# ensure that canonical pathing existing within vagrant-box
ln -s /vagrant/dev/atmosphere /opt/dev/atmosphere
ln -s /vagrant/dev/troposphere /opt/dev/troposphere
ln -s /vagrant/dev/atmosphere-ansible /opt/dev/atmosphere-ansible

# ensure that canonical `venv` are present within vagrant-box
ln -s  /vagrant/env/atmo /opt/env/atmo
ln -s  /vagrant/env/troposphere /opt/env/troposphere

# move all of 0.1 into Clank at some __future___ date

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
