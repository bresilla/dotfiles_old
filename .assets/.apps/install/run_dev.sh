sudo apt update
sudo apt install --assume-yes \
	build-essential \
	docker-ce \
	cmake \
	git \
	pkg-config \
	cmake-curses-gui \
	curl \
	python-pip \
	python-dev \
	python3-pip \
	python3-dev \
	pcl-tools \
	gcc \
	wget \
	unzip \
	checkinstall \
	protobuf-compiler \
  	libprotobuf-dev

sudo usermod -aG docker $USER

sudo apt install --assume-yes \
	libglfw3-dev \
	libusb-dev \
	libssl-dev

sudo apt install -y --no-install-recommends \
      	libgtest-dev \
      	libiomp-dev \
      	libleveldb-dev \
      	liblmdb-dev \
      	libopencv-dev \
      	libopenmpi-dev \
      	libsnappy-dev \
      	openmpi-bin \
      	openmpi-doc \
      	python-pydot

sudo apt-get install --assume-yes \
	golang \
	rustc \
	cargo \
	nodejs \
	dotnet-sdk-2.0.0
