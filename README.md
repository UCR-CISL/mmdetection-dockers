# MMDetection3D-dockers

This is a docker environment for [MMDetection3D](https://github.com/open-mmlab/mmdetection3d) repo. 
To get started, read their [getting_started_doc](https://mmdetection3d.readthedocs.io/en/latest/get_started.html)

### Prerequisites
Similar to carla official docker prerequisites
* Install docker following instructions [here](https://docs.docker.com/engine/install/)
* Install nvidia-docker2 following instructions [here](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#installation-guide)

## MMDetection3D

Build the image:
```
docker build -t cisl/mmdet --file mmdet.Dockerfile .
```

To test, run
```
docker run -it --gpus all cisl/mmdet
```

Inside the docker, run
```
mim download mmdet3d --config pointpillars_hv_secfpn_8xb6-160e_kitti-3d-car --dest .

python demo/pcd_demo.py demo/data/kitti/000008.bin pointpillars_hv_secfpn_8xb6-160e_kitti-3d-car.py hv_pointpillars_secfpn_6x8_160e_kitti-3d-car_20220331_134606-d42d15ed.pth
```
mim download mmdet3d --config pointpillars_hv_secfpn_8xb6-160e_kitti-3d-car --dest .
And check outputs/preds/000008.json
