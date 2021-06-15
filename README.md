# Docker OpenPCDet

This is a docker container with OpenPCDet installed. To build or use this, you need to install docker, as well as nvidia-docker to pass the GPU through to the container.

You can build the image with the following: 
```
./build.sh
```
The run script provided takes care of all the necessary Xforwarding required for Mayavi visualisation. Edit it to mount your local datasets and code base
```
./run.sh
```
