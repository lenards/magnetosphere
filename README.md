# Magnetosphere

_Magnetosphere_ provides a vagrant provisioning approach to creating an [Atmosphere](http://www.cyverse.org/atmosphere) development environment.

# Table of Contents

- [Magnetosphere](#magnetosphere)
- [(Assuming) Mac](#assuming-mac)
  - [using `vagrant`](#using-vagrant)
  - [Get Magnetosphere](#get-magnetosphere)
  - [Inside MAGNETOSPHERE_HOME](#inside-magnetosphere_home)
  - [Get Clank](#get-clank)
- [Inside Your Vagrant Box](#inside-your-vagrant-box)
  - [Run `kickstart.sh`](#run-kickstartsh)
  - [After ...](#after-)


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
├── {{secrets-repo}}
├── clank
├── pre-flight-c
└── kickstart.sh
```

**NOTE:** you may want to change `MOCK_USERNAME` in `variables.yml@vagrant`


## Get Clank

- clone [clank](https://github.com/iPlantCollaborativeOpenSource/clank)
```
git clone https://github.com/iPlantCollaborativeOpenSource/clank.git
```

# Inside Your Vagrant Box

To begin ... 

```
$ vagrant up 
Bringing machine 'atmo-api' up with 'virtualbox' provider...
==> atmo-api: Importing base box 'ubuntu/trusty64'...
==> atmo-api: Matching MAC address for NAT networking...
==> atmo-api: Checking if box 'ubuntu/trusty64' is up to date...
==> atmo-api: A newer version of the box 'ubuntu/trusty64' is available! You currently
==> atmo-api: have version '20150907.0.0'. The latest is version '20160120.0.1'. Run
==> atmo-api: `vagrant box update` to update.
==> atmo-api: Setting the name of the VM: magnetosphere_atmo-api_1453751731307_24339
==> atmo-api: Clearing any previously set forwarded ports...
==> atmo-api: Clearing any previously set network interfaces...
==> atmo-api: Preparing network interfaces based on configuration...
    atmo-api: Adapter 1: nat
    atmo-api: Adapter 2: hostonly
==> atmo-api: Forwarding ports...
    atmo-api: 22 => 2222 (adapter 1)
==> atmo-api: Running 'pre-boot' VM customizations...
==> atmo-api: Booting VM...
==> atmo-api: Waiting for machine to boot. This may take a few minutes...
    atmo-api: SSH address: 127.0.0.1:2222
    atmo-api: SSH username: vagrant
    atmo-api: SSH auth method: private key
    atmo-api: Warning: Connection timeout. Retrying...
    atmo-api: 
    atmo-api: Vagrant insecure key detected. Vagrant will automatically replace
    atmo-api: this with a newly generated keypair for better security.
    atmo-api: 
    atmo-api: Inserting generated public key within guest...
    atmo-api: Removing insecure key from the guest if it's present...
    atmo-api: Key inserted! Disconnecting and reconnecting using new SSH key...
==> atmo-api: Machine booted and ready!
==> atmo-api: Checking for guest additions in VM...
    atmo-api: The guest additions on this VM do not match the installed version of
    atmo-api: VirtualBox! In most cases this is fine, but in rare cases it can
    atmo-api: prevent things such as shared folders from working properly. If you see
    atmo-api: shared folder errors, please make sure the guest additions within the
    atmo-api: virtual machine match the version of VirtualBox you have installed on
    atmo-api: your host and reload your VM.
    atmo-api: 
    atmo-api: Guest Additions Version: 4.3.10
    atmo-api: VirtualBox Version: 5.0
==> atmo-api: Configuring and enabling network interfaces...
==> atmo-api: Mounting shared folders...
    atmo-api: /vagrant => /Users/lenards/devel/magnetosphere
==> atmo-api: Running provisioner: shell...
    atmo-api: Running: inline script
    ....
    ...
    ..
    .

```

You can see a live capture of the `vagrant up` process if you are [_curious_](https://asciinema.org/a/cwwjic9lttp5aewfzuui7c3xg).

Once that's done, you've got a running virtual machine to log into. 

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
$ service atmosphere start
```

[![asciicast](https://asciinema.org/a/6kpdcv8mwabfmqpv2o22dnaup.png =472x397)](https://asciinema.org/a/6kpdcv8mwabfmqpv2o22dnaup)

## After ... 

- review "docs" (that doesn't exist) about secrets ... 


## Notes 

You might want install Mac specifics for hosting Virtualbox

**Note:** _if you have a Virtualbox VMs running, they **must** be suspended/halted..._

It appears that the current `virtualbox` cask is including the extension pack. But if for some reason you need to install it, there is a _brew cask_:
```
brew cask install virtualbox-extension-pack
```
