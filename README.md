# Docker OpenPCDet

This is a docker build with OpenPCDet installed. Clone this repo and its submodules:
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

After you run the image, you can test a model with:
```
cd /root/OpenPCDet/tools && python3 demo.py --cfg_file cfgs/kitti_models/pv_rcnn.yaml     --ckpt /root/OpenPCDet/tools/pv_rcnn_8369.pth     --data_path /root/OpenPCDet/data/kitti/training/velodyne
```
