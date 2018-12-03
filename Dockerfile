FROM nvidia/cuda:9.0-cudnn7-devel-ubuntu16.04

# Install dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
        ca-certificates \
        cmake \
        git \
        libboost-all-dev \
        libgflags-dev \
        libgoogle-glog-dev \
        libprotobuf-dev \
        pkg-config \
        protobuf-compiler \
        python-yaml \
        wget \
        python3.5-dev \
        libpython3.5-dev \
        python3-numpy \
        build-essential \
    && rm -rf /var/lib/apt/lists/*

# Install pip for python3.5
RUN wget https://bootstrap.pypa.io/get-pip.py \
&& python3 get-pip.py \
&& rm get-pip.py

# Install OpenCV 3.4.1
RUN git clone --depth 1 -b 3.4.1 https://github.com/opencv/opencv.git /opencv && \
    git clone --depth 1 -b 3.4.1 https://github.com/opencv/opencv_contrib.git /opencv_contrib && \
    cd /opencv && \
    mkdir build && cd build && \
    cmake -DCMAKE_BUILD_TYPE=Release \
          -DCMAKE_INSTALL_PREFIX=/usr/local \
          -DBUILD_SHARED_LIBS=ON \
          -DWITH_JPEG=ON -DBUILD_JPEG=ON -DWITH_PNG=ON -DBUILD_PNG=ON \
          -DINSTALL_PYTHON_EXAMPLES=ON \
          -DINSTALL_C_EXAMPLES=OFF \
          -DOPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
          -DBUILD_EXAMPLES=ON .. && \
    make -j"$(nproc)" install && ldconfig && \
    rm -rf /opencv && rm -rf /opencv_contrib

# Install Tensorrt
# https://docs.nvidia.com/deeplearning/sdk/tensorrt-install-guide/index.html
# RUN wget https://url-to-tensorrt.tar.gz \
#     && tar zxvf TensorRT-4.0.0.3.Ubuntu-16.04.4.x86_64-gnu.cuda-9.0.cudnn7.0.tar.gz \
#     && mv TensorRT-4.0.0.3/lib/* /usr/local/lib/ \
#     && pip3 install --upgrade numpy \
#     && pip3 install TensorRT-4.0.0.3/python/tensorrt-4.0.0.3-cp35-cp35m-linux_x86_64.whl \
#     && pip3 install TensorRT-4.0.0.3/uff/uff-0.3.0-py2.py3-none-any.whl \
#     && rm TensorRT-4.0.0.3 TensorRT-4.0.0.3.Ubuntu-16.04.4.x86_64-gnu.cuda-9.0.cudnn7.0.tar.gz -rf

