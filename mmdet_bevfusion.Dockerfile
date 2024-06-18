FROM cisl/mmdet

RUN wget https://download.openmmlab.com/mmdetection3d/v1.1.0_models/bevfusion/bevfusion_lidar-cam_voxel0075_second_secfpn_8xb4-cyclic-20e_nus-3d-5239b1af.pth
RUN wget https://download.openmmlab.com/mmdetection3d/v1.1.0_models/bevfusion/bevfusion_lidar_voxel0075_second_secfpn_8xb4-cyclic-20e_nus-3d-2628f933.pth

# Need to run the following outside dockerfile, inside the instance,
# sudo `which python` projects/BEVFusion/setup.py develop
# Running from the dockerfile would incur error: fatal error: cuda_runtime_api.h:
# Maybe a privilege/path issue TBD