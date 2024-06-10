FROM pytorch/pytorch:2.1.1-cuda12.1-cudnn8-devel

# MMDetection3D
RUN pip install -U openmim
RUN mim install mmengine
RUN mim install 'mmcv>=2.0.0rc4'
RUN mim install 'mmdet>=3.0.0'
RUN mim install "mmdet3d>=1.1.0"

# Packages
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y git sudo nano mlocate libgl1 libglib2.0-0 --no-install-recommends

# Create user
RUN useradd -ms /bin/bash mmdet \
    && usermod -aG sudo mmdet \
    && echo "mmdet:mmdet" | chpasswd

USER mmdet
WORKDIR /home/mmdet

