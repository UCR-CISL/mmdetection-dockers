FROM cisl/mmdet

RUN wget https://download.openmmlab.com/mmdetection3d/data/waymo_mmdet3d_after_1x4/waymo_mini.tar.gz
RUN tar -xzvf waymo_mini.tar.gz -C ./data/
RUN mv data/Waymo_mini data/waymo
RUN rm waymo_mini.tar.gz

RUN pip install waymo-open-dataset-tf-2-12-0==1.6.4