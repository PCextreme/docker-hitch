# Hitch in Docker
Docker container for running [Hitch](https://hitch-tls.org/), a scalable TLS proxy.

It compiles Hitch and installs a simple example configuration.

# Building
Building the container can be done with docker:

    docker build -t hitch .

You can override the version of Hitch to build by supplying the HITCH_VERSION argument during build.

# Running
You can run the container and it will start with the default config.

    docker run hitch

It will look for */etc/hitch/hitch.conf*, so you can override this with a volume mapping:

    docker run -v /path/to/hitch.conf:/etc/hitch/hitch.conf hitch

# Registry
This image is available in the docker registry at pcextreme/hitch:

    docker pull pcextreme/hitch
