# About

Create a laser labyrinth and use this application to monitor the end of the laser(s) on the wall.

# Local Usage

## Needed library

```
# Local build
sudo apt install libasound2-dev

# Cross build
REL=$(lsb_release -sc)
sudo dpkg --add-architecture armhf
sudo add-apt-repository "deb [arch=armhf] http://ports.ubuntu.com/ ${REL} main universe multiverse restricted"
sudo add-apt-repository "deb [arch=armhf] http://ports.ubuntu.com/ ${REL}-updates main universe multiverse restricted"
sudo add-apt-repository "deb [arch=armhf] http://ports.ubuntu.com/ ${REL}-security main universe multiverse restricted"
sudo add-apt-repository "deb [arch=armhf] http://ports.ubuntu.com/ ${REL}-restricted main universe multiverse restricted"
sudo add-apt-repository "deb [arch=armhf] http://ports.ubuntu.com/ ${REL}-backports main universe multiverse restricted"
sudo apt-get update
sudo apt-get install crossbuild-essential-armhf gcc-arm-linux-gnueabi libasound2-dev:armhf

```

## Compile

`./create-local-release.sh`

The file is then in `build/bin/laser-game`

## Execute

To execute:
`./build/bin/laser-game`

# Create release

`./create-public-release.sh`

That will show the latest created version. Then, you can choose one and execute:
`./create-public-release.sh X.X.X`

# Use with debian

Get the version you want from https://deploy.foilen.com/laser-game/ .


```bash
wget https://deploy.foilen.com/laser-game/laser-game_X.X.X_YYYYY.deb
sudo dpkg -i laser-game_X.X.X_YYYYY.deb
```
