# Docker OpenPCDet

This is a docker build with OpenPCDet installed. Clone this repo and its submodules:
```
git clone https://github.com/janino163/docker-openpcdet.git --recursive
```


To build this, you need to install docker, as well as nvidia-docker to pass the GPU through to the container.

You can build the image with the following: 
```
./build.sh
```
The run script provided takes care of all the necessary Xforwarding required for Mayavi visualisation. Edit it to mount your local dataset.
```
./run.sh
```
For the first time that you run this, you'll have to install the repo with the following. It should finish with no issues.
```
python3 setup.py develop

```
Save the docker container with `docker commit ${CONTAINER ID} openpcdet:latest` 


Thereafter, download a model from the original [repo](https://github.com/open-mmlab/OpenPCDet/tree/master) such as `pv_rcnn_8369.pth` below and change the paths below to point to the pth file and data folders.
```
cd /root/OpenPCDet/tools && python3 demo.py --cfg_file cfgs/kitti_models/pv_rcnn.yaml     --ckpt /root/OpenPCDet/tools/pv_rcnn_8369.pth     --data_path /root/OpenPCDet/data/kitti/training/velodyne
```
