# About

Create a laser labyrinth and use this application to monitor the end of the laser(s) on the wall.

# Local Usage

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
wget https://deploy.foilen.com/laser-game/laser-game_X.X.X_amd64.deb
sudo dpkg -i laser-game_X.X.X_amd64.deb
```
