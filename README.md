# Docker OpenPCDet

This is a docker container with OpenPCDet installed. Clone this repo and its submodules:
```
git clone https://github.com/darrenjkt/docker-openpcdet.git --recursive
```


To build this, you need to install docker, as well as nvidia-docker to pass the GPU through to the container.

You can build the image with the following: 
```
./build.sh
```
The run script provided takes care of all the necessary Xforwarding required for Mayavi visualisation. Edit it to mount your local datasets and code base
```
./run.sh
```
