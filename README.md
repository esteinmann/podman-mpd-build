# Introduction

Utility scripts and container files to create a build environment for **M**usic **P**layer **D**aemon and run the compilation and installation.

# Usage

To build the container images and spin up a container with the compiled mpd installed invoke:

`./build_run.sh`

Test if mpd is running properly. You need to have mpc (Music Player Client) installed on your own system for this:

`mpc --port 6601`

For example update the database:

`mpc --port 6601 update`

Without a local install of mpc you can also run it inside the container (mpd is the name of the container created by the script):

`podman exec -it mpd mpc`

The following sections explain the individual steps inside `build_run.sh`

## Build image localhost/mpd-build

This sets up debian:bookworm with build dependencies in place.

`podman build -t mpd-build build-container`

## Build image localhost/mpd-run

Using localhost/mpd-build this will clone MPD's git repo, setup meson, run ninja compile and run ninja install.

`podman build --format docker -t mpd-run exec-container`

## Execute mpd-run

With port 6601 on host mapped to port 6600 on container (This allows MPD running on the host to keep using port 6600). Any music files you want to test with the compiled mpd can be placed in music-db.

`podman run --replace -d -v ./music-db:/music-db -p 6601:6600 --name mpd localhost/mpd-run`

# Config

A very minimal MPD config without real audio output is defined in `exec-container/mpd.conf` and available as /etc/mpd.conf in the container.
