ARG PYTORCH="2.1.1"
ARG CUDA="12.1"
ARG CUDNN="8"

FROM pytorch/pytorch:${PYTORCH}-cuda${CUDA}-cudnn${CUDNN}-devel


ENV TORCH_CUDA_ARCH_LIST="7.5;8.0;8.6;8.9+PTX;9.0" \
    TORCH_NVCC_FLAGS="-Xfatbin -compress-all" \
    CMAKE_PREFIX_PATH="$(dirname $(which conda))/../" \
    FORCE_CUDA="1"

# Avoid Public GPG key error
RUN rm -f /etc/apt/sources.list.d/cuda.list \
    /etc/apt/sources.list.d/nvidia-ml.list && \
    apt-key del 7fa2af80 || true && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1804/x86_64/3bf863cc.pub && \
    apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/machine-learning/repos/ubuntu1804/x86_64/7fa2af80.pub

# Install system dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git wget ffmpeg libsm6 libxext6 libxrender-dev libglib2.0-0 ninja-build \
    --no-install-recommends && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Install Python packages required for mmdet3d
RUN pip install --no-cache-dir \
    "numpy<2.0" \
    matplotlib \
    opencv-python

# Install OpenMMLab core libraries
RUN pip install --no-cache-dir mmcv==2.1.0 -f https://download.openmmlab.com/mmcv/dist/cu121/torch2.1/index.html && \
    pip install --no-cache-dir \
    mmengine>=0.7.1 \
    mmdet>=3.0.0 \
    mmdet3d==1.4.0

# Clone and install MMDetection3D, then setup BEVFusion if present
RUN git clone https://github.com/open-mmlab/mmdetection3d.git -b dev-1.x /mmdetection3d && \
    pip install --no-cache-dir -e /mmdetection3d 
    

# Setup BEVFusion
RUN cd /mmdetection3d && \
    if [ -f projects/BEVFusion/setup.py ]; then \
        python3 projects/BEVFusion/setup.py develop; \
    else \
        echo "BEVFusion setup.py not found"; \
    fi


# Set working directory
ENV PYTHONPATH=/mmdetection3d
WORKDIR /mmdetection3d

