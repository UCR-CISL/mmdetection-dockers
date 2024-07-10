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
