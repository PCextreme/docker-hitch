# Hitch in Docker
Docker container for running Hitch

It compiles Hitch and installs a simple example configuration.

# Building
Building the container can be done with docker:

<pre>docker build -t hitch .</pre>

After building it, you can run it.

# Running
You can run the container and it will start with the default config.

<pre>docker run hitch</pre>

It will look for /etc/hitch/hitch.conf, so you can override this with a volume mapping:

<pre>docker run -v /home/wido/Desktop/hitch:/etc/hitch hitch</pre>
