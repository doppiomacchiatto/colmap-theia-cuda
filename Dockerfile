FROM nvidia/cuda:11.0.3-devel-ubuntu20.04
MAINTAINER Juan Santisi "juan@santisi.io"

RUN apt-get update && DEBIAN_FRONTEND="noninteractive" TZ="America/New_York" apt-get install -y tzdata

RUN apt-get update && \
       apt-get install -y --no-install-recommends \
       apt-transport-https \
       apt-utils \
       automake \
       build-essential \
       bzip2 \
       ca-certificates \
       cmake \
       curl \
       git \
       freeglut3-dev \
       libcgal-dev \
       libatlas-base-dev \
       libsuitesparse-dev \
       libboost-all-dev \
       libgeotiff-dev \
       libboost-all-dev \
       libeigen3-dev \
       libsuitesparse-dev \
       libfreeimage-dev \
       libgoogle-glog-dev \
       libgflags-dev \
       libglew-dev \
       libhdf5-dev \
       libhwloc-dev \
       libjemalloc-dev \
       libjpeg-dev \
       libmetis-dev \
       libmpich-dev \
       libopenexr-dev \
       libopenimageio-dev \
       libproj-dev \
       libsuitesparse-dev \
       librocksdb-dev \
       libtbb2 \
       libtbb-dev \
       libtiff5-dev \
       libtool \
       libcurl4-gnutls-dev \
       libopenmpi-dev \
       libwebp-dev \
       libqt5opengl5-dev \
       make \
       mercurial \
       mpich \
       pkg-config \
       rapidjson-dev \
       software-properties-common \
       subversion \
       zlib1g-dev \
       cifs-utils \
       nfs-common \
       openssh-client \
       openssh-server \
       net-tools \
       qtbase5-dev \
       sshpass  \
       vim \
       wget && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# googletest
#
RUN git clone https://github.com/google/googletest.git && \
      cd  googletest && \
      cmake . && \
      make install && \
      cd .. && \
      rm -r googletest
#
# ceres-solver
#
RUN git clone https://github.com/ceres-solver/ceres-solver.git && \
      cd ceres-solver && \
      git checkout 1.14.0 && \
      mkdir ceres-bin && \
      cd ceres-bin && \
      cmake CXXFLAGS=-stc=c++11 .. \
        -DBUILD_TESTING=OFF \
        -DBUILD_DOCUMENTATION=OFF \
        -DBUILD_EXAMPLES=OFF \
        -DBUILD_SHARED_LIBS=ON && \
    make CXXFLAGS=-stc=c++11 -j4 && \
    make install && \
    cd ../.. && \
    rm -r ceres-solver

##TheiaSfM
#
RUN git clone https://github.com/sweeneychris/TheiaSfM.git && \
    cd TheiaSfM && \
    mkdir build && \
    cd build && \
    cmake CXXFLAGS=-std=c++11 .. && \
    make CXXFLAGS=-std=c++11 -j4 && \
    make install && \
    cd ../

#
#COLMAP
#
RUN git clone https://github.com/colmap/colmap.git && \
      cd colmap && \
      mkdir build && \
      cd build && \
      cmake CXXFLAGS=-std=c++11 .. && \
      make CXXFLAGS=-std=c++11 -j4 && \
      make install && \
      cd ..
##
# Set the LD_LIBRARY_PATH
##
ENV LD_LIBRARY_PATH = "/usr/local/lib"
