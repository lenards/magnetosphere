WORKSPACE="/vagrant"
GIT_BRANCH="master"
SERVER_NAME="localhost"
ENV_FILE="$WORKSPACE/atmo-extras/clank_init/build_env/variables.yml@local"

# Before running, ensure that `/vagrant` is present
# - if there isn't a `/vagrant` - someone might be 
#   trying to run this from the host of the vm - 
#   which is just a bag-of-hurt

#0. Begin, eh
cd "$WORKSPACE"


#sudo mkdir -p /opt/dev/atmosphere
#sudo chown vagrant:vagrant -R /opt/dev/atmosphere
#sudo mkdir -p /opt/env/atmo
#sudo chown vagrant:vagrant -R /opt/env/atmo


#1. Clone repos - pre-flight handles this
# ensure `atmo-extras` in place
# ensure `clank` in place

#2. Prepare execution of ratchet
virtualenv ratchet_env
. ratchet_env/bin/activate
pip install -r clank/ratchet_requirements.txt

#3. Running ratchet
cd "$WORKSPACE/clank"
PYTHONUNBUFFERED=1 python ratchet.py --workspace $WORKSPACE --env_file $ENV_FILE --skip "troposphere"

#4. Chown to vagrant, activate and run!
cd "$WORKSPACE"
sudo chown -R vagrant:vagrant .
cd "/opt/dev/atmosphere"
. "/opt/env/atmo/bin/activate"

