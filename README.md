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


## BEVFusion


Build the image:
```
docker build -t cisl/bevfusion --file mmdet_bevfusion.Dockerfile .
```

To test, run
```
docker run -it --gpus all cisl/bevfusion
```
Inside the docker, run
```
echo "mmdet" | sudo -S `which python` projects/BEVFusion/setup.py develop

CHECKPOINT_FILE=bevfusion_lidar-cam_voxel0075_second_secfpn_8xb4-cyclic-20e_nus-3d-5239b1af.pth

python projects/BEVFusion/demo/multi_modality_demo.py demo/data/nuscenes/n015-2018-07-24-11-22-45+0800__LIDAR_TOP__1532402927647951.pcd.bin demo/data/nuscenes/ demo/data/nuscenes/n015-2018-07-24-11-22-45+0800.pkl projects/BEVFusion/configs/bevfusion_lidar-cam_voxel0075_second_secfpn_8xb4-cyclic-20e_nus-3d.py ${CHECKPOINT_FILE} --cam-type all --score-thr 0.2
```

Unfortunately, the current version model and checkpoint has mismatched layer dimensions (as of Jun 2024).
