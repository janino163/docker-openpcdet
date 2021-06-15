FROM nvidia/cuda:10.1-cudnn7-devel

ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Australia/Sydney
ENV HOME=/root

RUN apt update && apt install -y \
    python3 \
    python3-pip \
    apt-transport-https \
    ca-certificates \
    gnupg \
    software-properties-common \
    wget \
    git \
    ninja-build \
    libboost-dev \
    build-essential && \
    rm -rf /var/lib/apt/lists/*

# Install PyTorch
RUN pip3 install torch==1.5 torchvision==0.6.0

# Install CMake
RUN wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - > /etc/apt/trusted.gpg.d/kitware.gpg
RUN apt-add-repository 'deb https://apt.kitware.com/ubuntu/ bionic main'
RUN apt-get update && apt install -y cmake

# Install spconv
COPY spconv $HOME/spconv
WORKDIR $HOME/spconv
ENV SPCONV_FORCE_BUILD_CUDA=1
RUN python3 setup.py bdist_wheel
RUN pip3 install dist/*.whl

# Install LLVM 10
WORKDIR $HOME
RUN wget https://apt.llvm.org/llvm.sh && chmod +x llvm.sh && ./llvm.sh 10

# OpenPCDet dependencies fail to install unless LLVM 10 exists on the system
# and there is a llvm-config binary available, so we have to symlink it here.
RUN ln -s /usr/bin/llvm-config-10 /usr/bin/llvm-config

ARG TORCH_CUDA_ARCH_LIST="5.2 6.0 6.1 7.0 7.5+PTX"

# Install OpenPCDet
COPY OpenPCDet $HOME/OpenPCDet
WORKDIR $HOME/OpenPCDet
RUN pip3 install --upgrade pip
RUN pip3 install -r requirements.txt
RUN python3 setup.py develop

# Xvfb
RUN apt-get install -yq --no-install-recommends \
    xvfb \
    x11-utils \
    libx11-dev \
    qt5-default \
    && apt-get clean

# Mayavi installation dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    ffmpeg \
    libsm6 \
    libxext6 \
    libjpeg-dev \
    libpng-dev \
    libxcb-icccm4 \
    libxcb-image0 \
    libxcb-keysyms1 \
    libxcb-randr0 \
    libxcb-render-util0 \
    libxcb-xkb1 \
    libxkbcommon-x11-0 \
    libxcb-xinerama0 \
    python3-opencv
    
RUN pip3 install \
    opencv-python \
    vtk \
    pyqt5 \
    mayavi \
    open3d \
    pillow==6.1


# Clean image
RUN apt-get clean && rm -rf /var/lib/apt/lists/* 