# Magnetosphere

_Magnetosphere_ provides a vagrant provisioning approach to creating an [Atmosphere](http://www.cyverse.org/atmosphere) development environment.

# Table of Contents
- [Magnetosphere](#magnetosphere)
- [Table of Contents](#table-of-contents)
- [(Assuming) Mac](#assuming-mac)
  - [using `vagrant`](#using-vagrant)
  - [Get Magnetosphere](#get-magnetosphere)
  - [Inside `MAGNETOSPHERE_HOME`](#inside-magnetosphere_home)
  - [Get Clank](#get-clank)
- [Inside Your Vagrant Box](#inside-your-vagrant-box)
  - [Snapshot - it's _quite_ progressive](#snapshot---its-_quite_-progressive)
  - [Step inside ...](#step-inside-)
  - [Run `kickstart.sh`](#run-kickstartsh)
  - [Getting the Databases Loaded...](#getting-the-databases-loaded)
  - [After ...](#after-)
  - [Notes](#notes)

# (Assuming) Mac
- ensure XCode is install

- agree to the XCode license: `sudo xcodebuild -license`

- install [brew](http://brew.sh/) (if not already installed)

- install Virtualbox via "brew cask"

```
brew tap caskroom/cask
brew install brew-cask
brew cask install virtualbox
```

- install vagrant

```
brew cask install vagrant
```

## using `vagrant`

- download/add `ubuntu/trusty64` [box](https://atlas.hashicorp.com/ubuntu/boxes/trusty64)

Note: _depending on your connection's bandwidth this could take 2 to 5 minutes..._

```
$ vagrant box add ubuntu/trusty64

==> box: Loading metadata for box 'ubuntu/trusty64'
    box: URL: https://atlas.hashicorp.com/ubuntu/trusty64
==> box: Adding box 'ubuntu/trusty64' (v20160127.0.0) for provider: virtualbox
    box: Downloading: https://vagrantcloud.com/ubuntu/boxes/trusty64/versions/20160127.0.0/providers/virtualbox.box
    box: Progress: 1% (Rate: 320k/s, Estimated time remaining: 0:21:01)
    ... 2 to 10 minutes elapse ...
==> box: Successfully added box 'ubuntu/trusty64' (v20160127.0.0) for 'virtualbox'!
```

## Get Magnetosphere

```
git clone https://github.com/lenards/magnetosphere.git
```

## Inside `MAGNETOSPHERE_HOME`

We will _stage_ the missing *"bits"* that are necessary for installation in the folder where our `Vagrantfile` is. I will refer to this as `MAGNETOSPHERE_HOME` when walking through the steps for getting the vagrant VM working. 

For the most part, the missing *"bits"* are all available for the Atmosphere team in the _secrets_ repo. But Clank discusses [these files](https://github.com/iPlantCollaborativeOpenSource/clank#list-of-files-needed-before-hand) as well.

Our goal is for `MAGNETOSPHERE_HOME` to looking like this:
```
$ tree -L 1 . 
.
├── LICENSE
├── README.md
├── Vagrantfile
├── pre-flight-check.sh
├── kickstart.sh
└── scratch
    ├── {{secrets-repo}}
    └── clank
```

We need to: 
- [ ] ensure _{{secrets-repo}}_ in place within `MAGNETOSPHERE_HOME`
- [ ] Clank is cloned into `MAGNETOSPHERE_HOME`

**NOTE:** you may want to change `MOCK_USERNAME` in `variables.yml@vagrant`


## Get Clank

- clone [clank](https://github.com/iPlantCollaborativeOpenSource/clank)
```
git clone https://github.com/iPlantCollaborativeOpenSource/clank.git
```

## Secrets

... you'll have to ask @lenards or @steve-gregory about that (for _now_)

# Inside Your Vagrant Box

To begin ... 

```
$ vagrant up 
Bringing machine 'atmosphere-dev' up with 'virtualbox' provider...
==> atmosphere-dev: Importing base box 'ubuntu/trusty64'...
==> atmosphere-dev: Matching MAC address for NAT networking...
==> atmosphere-dev: Checking if box 'ubuntu/trusty64' is up to date...
==> atmosphere-dev: A newer version of the box 'ubuntu/trusty64' is available! You currently
==> atmosphere-dev: have version '20150907.0.0'. The latest is version '20160120.0.1'. Run
==> atmosphere-dev: `vagrant box update` to update.
==> atmosphere-dev: Setting the name of the VM: magnetosphere_atmosphere-dev_1453751731307_24339
==> atmosphere-dev: Clearing any previously set forwarded ports...
==> atmosphere-dev: Clearing any previously set network interfaces...
==> atmosphere-dev: Preparing network interfaces based on configuration...
    atmosphere-dev: Adapter 1: nat
    atmosphere-dev: Adapter 2: hostonly
==> atmosphere-dev: Forwarding ports...
    atmosphere-dev: 22 => 2222 (adapter 1)
==> atmosphere-dev: Running 'pre-boot' VM customizations...
==> atmosphere-dev: Booting VM...
==> atmosphere-dev: Waiting for machine to boot. This may take a few minutes...
    atmosphere-dev: SSH address: 127.0.0.1:2222
    atmosphere-dev: SSH username: vagrant
    atmosphere-dev: SSH auth method: private key
    atmosphere-dev: Warning: Connection timeout. Retrying...
    atmosphere-dev: 
    atmosphere-dev: Vagrant insecure key detected. Vagrant will automatically replace
    atmosphere-dev: this with a newly generated keypair for better security.
    atmosphere-dev: 
    atmosphere-dev: Inserting generated public key within guest...
    atmosphere-dev: Removing insecure key from the guest if it's present...
    atmosphere-dev: Key inserted! Disconnecting and reconnecting using new SSH key...
==> atmosphere-dev: Machine booted and ready!
==> atmosphere-dev: Checking for guest additions in VM...
    atmosphere-dev: The guest additions on this VM do not match the installed version of
    atmosphere-dev: VirtualBox! In most cases this is fine, but in rare cases it can
    atmosphere-dev: prevent things such as shared folders from working properly. If you see
    atmosphere-dev: shared folder errors, please make sure the guest additions within the
    atmosphere-dev: virtual machine match the version of VirtualBox you have installed on
    atmosphere-dev: your host and reload your VM.
    atmosphere-dev: 
    atmosphere-dev: Guest Additions Version: 4.3.10
    atmosphere-dev: VirtualBox Version: 5.0
==> atmosphere-dev: Configuring and enabling network interfaces...
==> atmosphere-dev: Mounting shared folders...
    atmosphere-dev: /vagrant => /Users/lenards/devel/magnetosphere
==> atmosphere-dev: Running provisioner: shell...
    atmosphere-dev: Running: inline script
    ....
    ....
    ....
==> atmosphere-dev: Setting up python2.7-dev (2.7.6-8ubuntu0.2) ...
==> atmosphere-dev: Setting up python-dev (2.7.5-5ubuntu3) ...
==> atmosphere-dev: Setting up python-distlib (0.1.8-1ubuntu1) ...
==> atmosphere-dev: Setting up python-distlib-whl (0.1.8-1ubuntu1) ...
==> atmosphere-dev: Setting up python-html5lib (0.999-3~ubuntu1) ...
==> atmosphere-dev: Setting up python-html5lib-whl (0.999-3~ubuntu1) ...
==> atmosphere-dev: Setting up python-six-whl (1.5.2-1ubuntu1) ...
==> atmosphere-dev: Setting up python-urllib3-whl (1.7.1-1ubuntu4) ...
==> atmosphere-dev: Setting up python-requests-whl (2.2.1-1ubuntu0.3) ...
==> atmosphere-dev: Setting up python-setuptools-whl (3.3-1ubuntu2) ...
==> atmosphere-dev: Setting up python-pip-whl (1.5.4-1ubuntu3) ...
==> atmosphere-dev: Setting up python-setuptools (3.3-1ubuntu2) ...
==> atmosphere-dev: Setting up python-pip (1.5.4-1ubuntu3) ...
==> atmosphere-dev: Setting up python-wheel (0.24.0-1~ubuntu1) ...
==> atmosphere-dev: Processing triggers for libc-bin (2.19-0ubuntu6.6) ...
==> atmosphere-dev: Python 2.7.6
==> atmosphere-dev: pip 1.5.4 from /usr/lib/python2.7/dist-packages (python 2.7)
==> atmosphere-dev: Downloading/unpacking pip from https://pypi.python.org/packages/py2.py3/p/pip/pip-8.0.3-py2.py3-none-any.whl#md5=b234250205337ff67967dff300001e3d
==> atmosphere-dev: Downloading/unpacking virtualenv
==> atmosphere-dev: Installing collected packages: pip, virtualenv
==> atmosphere-dev:   Found existing installation: pip 1.5.4
==> atmosphere-dev:     Not uninstalling pip at /usr/lib/python2.7/dist-packages, owned by OS
==> atmosphere-dev: Successfully installed pip virtualenv
==> atmosphere-dev: Cleaning up...
```

You can see a live capture of the `vagrant up` process if you are [_curious_](https://asciinema.org/a/cwwjic9lttp5aewfzuui7c3xg).

Once that's done, you've got a running virtual machine to log into. 


## Snapshot - it's _quite_ progressive 

Since we are using VirtualBox (VBox) as a provider, we'll use a VBox-specific _vagrant plugin_ to handling saving snapshots. 

```
$ vagrant plugin install vagrant-vbox-snapshot 
Installing the 'vagrant-vbox-snapshot' plugin. This can take a few minutes...
Installed the plugin 'vagrant-vbox-snapshot (0.0.10)'!
```

The commands are slightly different than what you'll see in the Vagrant docs for `vagrant snapshot`:

```
$ vagrant snapshot help
Usage: vagrant snapshot <command> [<args>]

Available subcommands:
     back
     delete
     go
     list
     take

For help on any individual command run `vagrant snapshot <command> -h`

```

Before we log into the box, we should create an initial _snapshot_ that we can _restore_ to later (if needed). The command within the plugin we want is `take`, we need to provide a name for the snapshot and _vm-name_ (this is defined within the `Vagrantfile`):

```
$ vagrant snapshot take --help 
Take snapshot

Usage: vagrant snapshot take [vm-name] <SNAPSHOT_NAME>
```

By default, the `Vagrantfile` file specifies `atmosphere-dev` as the _vm-name_.

```
$ vagrant snapshot take atmosphere-dev INIT
Taking snapshot INIT
0%...10%...20%...30%...40%...50%...60%...70%...80%...90%...100%
Snapshot taken. UUID: 2d60fb56-49ab-4a11-ad15-876c0129cdb1
```

For more information, see the README for [vagrant-vbox-snapshot](https://github.com/dergachev/vagrant-vbox-snapshot) repository.


## Step inside ... 

Let's log into the vagrant box we've created:
```
vagrant ssh
```

Everything on your local machine (which is the "host") is accessible within the vagrant (guest) box via `/vagrant`.  We can use this to our advantage when providing data or trying to get files out of the _guest_ to the _host_.


## Run `kickstart.sh` 

_(ensure that the `pre-flight-check.sh` passes prior to this step)_

This is going to run the combination of `ratchet.py` &  playbooks in [clank](https://github.com/iPlantCollaborativeOpenSource/clank). 

We're going to use a slight abstraction to run _ratchet & clank_ that mimics how all build & deploys happen (we do this via Jenkins as a shell-script build step, but we're calling that _step_ `kickstart.sh`).

_{{not complete}}_ 
```
$ vagrant ssh 
... 
$ sudo su - 
$ cd /vagrant
$ ./pre-flight-check.sh
...
$ ./kickstart.sh
...
... «such output; much fact; lvl=ansible»
$ service atmosphere status
...
$ service nginx restart
$ service atmosphere start
```

[![asciicast](https://asciinema.org/a/6kpdcv8mwabfmqpv2o22dnaup.png)](https://asciinema.org/a/6kpdcv8mwabfmqpv2o22dnaup)

## Getting the Databases Loaded... 

_*NOTE*: this step is something that should be (very soon) done by Clank_ 

You will need to know what the database names are in use. Lucky for us, the information was present in the _BUILD_ENV_ file. 

So we can grep for `DBNAME` and find the names of the databases that Clank created during the _kickstart_:

```
root@vagrant-ubuntu-trusty-64:/vagrant# grep DBNAME $BUILD_ENV_PATH/variables.yml@vagrant 
ATMO_DBNAME: aeolian
TROPO_DBNAME: thermogram
```

We need to do the next actions as `postgres` user: 
```
$ su - postgres
$ cd /vagrant
...
... `ls` or check on your sql-dump paths since we're being all manual
...
$ psql -d aeolian < /vagrant/prod-sql-dump-for-atmosphere-release-date.sql
... such output ...
$ psql -d thermogram < /vagrant/prod-sql-dump-for-troposphere-release-date.sql
... such output ... 
$ exit 
$ service postgresql restart 
$ service atmosphere restart 
```

You can verify that the API is working as expected by going to the Django REST Framework page for the API (in your _host_, aka your Mac): 
```
open https://192.168.72.19/api/sizes
```

## After ... 

- review "docs" (that doesn't exist) about secrets ... 


## Notes 

You might want install Mac specifics for hosting Virtualbox

**Note:** _if you have a Virtualbox VMs running, they **must** be suspended/halted..._

It appears that the current `virtualbox` cask is including the extension pack. But if for some reason you need to install it, there is a _brew cask_:
```
brew cask install virtualbox-extension-pack
```
