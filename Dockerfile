FROM ubuntu:18.04

ENV OPENCV_VERSION 3.4.5

RUN apt-get -y update && \
	apt-get -y upgrade && \
	apt-get remove x264 libx264-dev && \

# Install dependencies

	apt-get -y install \ 
		python3 \
        python3-dev \
        git \
        wget \
        unzip \
        cmake \
        build-essential \
        pkg-config \
        libatlas-base-dev \
        gfortran \
        libgtk2.0-dev \
        libavcodec-dev \
        libavformat-dev \
        libswscale-dev \
        libjpeg-dev \
        libpng-dev \
        libtiff-dev \
        libv4l-dev \
        octave \
	octave-image \
	octave-financial \
	octave-nan \
        liboctave-dev \
    	&& \ 
    apt-get clean

    RUN wget https://github.com/opencv/opencv/archive/$OPENCV_VERSION.zip -O opencv3.zip && \	
    unzip -q opencv3.zip && \
    mv /opencv-$OPENCV_VERSION /opencv && \
    rm opencv3.zip && \
    wget https://github.com/opencv/opencv_contrib/archive/$OPENCV_VERSION.zip -O opencv_contrib3.zip && \
    unzip -q opencv_contrib3.zip && \
    mv /opencv_contrib-$OPENCV_VERSION /opencv_contrib && \
    rm opencv_contrib3.zip \
    && \

    mkdir /opencv/build && cd /opencv/build && \
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
      -D BUILD_PYTHON_SUPPORT=ON \
      -D CMAKE_INSTALL_PREFIX=/usr/local \
      -D OPENCV_EXTRA_MODULES_PATH=/opencv_contrib/modules \
      -D BUILD_EXAMPLES=OFF \
      -D PYTHON_DEFAULT_EXECUTABLE=/usr/bin/python3 \
      -D BUILD_opencv_python3=ON \
      -D BUILD_opencv_python2=OFF \
      -D WITH_IPP=OFF \
      -D WITH_FFMPEG=ON \
      -D WITH_V4L=ON .. \
    && \
    cd /opencv/build && \
    make -j$(nproc) && \
    make install && \
    ldconfig \
    && \
    rm -rf /opencv /opencv_contrib /var/lib/apt/lists/*

    RUN git clone https://github.com/votchallenge/trax.git && \
    mkdir trax/build && \
    cd trax/build && \
    cmake .. && \
    make && \
    make install && \
    cd ../.. && \
    rm -rf trax

    CMD ["python3 --version"]
