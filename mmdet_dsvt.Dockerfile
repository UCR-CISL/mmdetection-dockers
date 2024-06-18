FROM cisl/mmdet:waymo_mini

# RUN pip install torch-scatter==2.0.9 # Not compatible anymore
RUN pip install torch-scatter -f https://data.pyg.org/whl/torch-2.1.0+cu121.html


# Need to run the following outside dockerfile, inside the instance,
# sudo `which python` projects/DSVT/setup.py develop
# Running from the dockerfile would incur error: fatal error: cuda_runtime_api.h:
# Maybe a privilege/path issue TBD