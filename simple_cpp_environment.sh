# Spesific installation flags
gxx_only=false
make_only=false
cmake_only=false
git_only=false
boost_only=false
nghttp2_only=false
google_bm_only=false

  
# If no argument providing by user install all libs
if [[ $# -eq 0 || $1 == "--all"  ]]
then
    echo ""
    echo "	Installing libs listed below "
    echo "=========================================="
    echo ""
    echo " >>>>>>>>> gcc-8 && g++-8"
    echo " >>>>>>>>> make "
    echo " >>>>>>>>> cmake v3.20 "
    echo " >>>>>>>>> git (latest)"
    echo " >>>>>>>>> boost v1.75.0"
    echo " >>>>>>>>> nghttp2 v1.41.0"
    echo " >>>>>>>>> google benchmark"
    echo "=========================================="
    echo ""
    

    gxx_only=true
	make_only=true
	cmake_only=true
	git_only=true
	boost_only=true
	nghttp2_only=true
	google_bm_only=true
fi

if [[ $1 == "--no_boost"  ]]
then
    echo ""
    echo "	Installing libs listed below "
    echo "=========================================="
    echo ""
    echo " >>>>>>>>> gcc-8 && g++-8"
    echo " >>>>>>>>> make "
    echo " >>>>>>>>> cmake v3.20 "
    echo " >>>>>>>>> git (latest)"
    echo " >>>>>>>>> google benchmark"


    gxx_only=true
	make_only=true
	cmake_only=true
	git_only=true
	google_bm_only=true
fi

if [[ $1 == "--gxx" ]] 
then 
    echo "gxx-8 is going to install"
    gxx_only=true
fi
if [[ $1 == "--make" ]] 
then 
    echo "make is going to install"
    make_only=true
fi

if [[ $1 == "--cmake" ]] 
then 
    echo "cmake is going to install"
    cmake_only=true
fi
if [[ $1 == "--git" ]] 
then 
    echo "git is going to install"
    git_only=true
fi
if [[ $1 == "--boost" ]] 
then 
    echo "boost-lib is going to install"
    boost_only=true
fi
if [[ $1 == "--nghttp2" ]] 
then 
    echo "nghttp2 is going to install"
    nghttp2_only=true
fi
if [[ $1 == "--gbm" ]] 
then 
    echo "google benchmark is going to install"
    google_bm_only=true
fi

if $gxx_only
then
	echo ">>>>>>>> Installing GXX 8"
	sudo apt-get update -y && \
	sudo apt-get upgrade -y && \
	sudo apt-get install build-essential software-properties-common -y && \
	sudo add-apt-repository ppa:ubuntu-toolchain-r/test -y && \
	sudo apt-get update -y && \
	sudo apt-get install gcc-8 g++-8 -y && \
	sudo update-alternatives --install /usr/bin/gcc gcc /usr/bin/gcc-8 60 --slave /usr/bin/g++ g++ /usr/bin/g++-8 && \
	sudo update-alternatives --config gcc
fi

if $make_only
then
	echo ">>>>>>>> make"
	sudo apt-get install make
fi

if $git_only
then
	echo ">>>>>>>> Installing git"
	sudo add-apt-repository ppa:git-core/ppa -y
	sudo apt update
	sudo apt install git
fi

if $cmake_only
then
	echo ">>>>>>>> Installing cmake-3.20"
	echo "For more information check --> https://cmake.org/install/"
	wget https://cmake.org/files/v3.20/cmake-3.20.0-rc3.tar.gz
	tar -xvzf cmake-3.20.0-rc3.tar.gz
	sudo rm -rf cmake-3.20.0-rc3.tar.gz
	cd cmake-3.20.0-rc3
	sudo ./boostrap
	sudo make 
	sudo make install
fi

if $boost_only
then
	echo ">>>>>>>> Installing boost pre-request package"
	echo "For more information check --> https://www.boost.org/doc/libs/1_75_0/more/getting_started/unix-variants.html"

	#Install pre-request package (recommended)
	echo ">>>>>>>> Installing which-2.21 (recommended package)"
	wget https://ftp.gnu.org/gnu/which/which-2.21.tar.gz
	tar -xvzf which-2.21.tar.gz
	sudo rm -rf which-2.21.tar.gz
	cd which-2.21
	./configure --prefix=/usr && make
	sudo make install

	echo ">>>>>>>> Installing boost-1.75"
	wget https://dl.bintray.com/boostorg/release/1.75.0/source/boost_1_75_0.tar.gz
	tar -xvzf boost_1_75_0.tar.gz
	sudo rm -rf boost_1_75_0.tar.gz
	cd boost_1_75_0
	./bootstrap.sh --prefix=/usr --with-python=python3 && ./b2 stage -j4 threading=multi link=shared
	sudo ./b2 install threading=multi link=shared  
fi

if $nghttp2_only
then
	echo ">>>>>>>> Installing nghttp2 && nghttp2-asio"
	echo "For more information check --> https://nghttp2.org/documentation/libnghttp2_asio.html"

	sudo apt-get install 	binutils autoconf automake autotools-dev libtool pkg-config \
	  						zlib1g-dev libcunit1-dev libssl-dev libxml2-dev libev-dev libevent-dev libjansson-dev \
	  						libc-ares-dev libjemalloc-dev libsystemd-dev \
	  						cython python3-dev python-setuptools

	git clone --branch v1.41.0 https://github.com/nghttp2/nghttp2.git
	cd nghttp2
	autoreconf -i
	automake
	autoconf
	sudo ./configure --enable-asio-lib
	make
fi

if $google_bm_only
then
	echo ">>>>>>>> Installing google benchmark"
	echo "For more information check --> https://github.com/google/benchmark"
	
	git clone https://github.com/google/benchmark.git
	git clone https://github.com/google/googletest.git benchmark/googletest
	cd benchmark
	cmake -E make_directory "build"
	cmake -E chdir "build" cmake -DCMAKE_BUILD_TYPE=Release ../
	cmake --build "build" --config Release
fi

if [[ $1 == "--help" ]] 
then 
	echo ""
    echo "To install spesific library, pass argument after ./simple_cpp_environment --[arg] "
    echo "===================================================================================="
    echo "--gxx			 gcc-8 && g++-compiler"		
    echo "--make			 make"		
    echo "--boost			 boost-1.75.0"		
    echo "--no_boost		 Install all libs except boost and nghttp2"		
    echo "--git			 git latest version"		
    echo "--cmake			 Cmake-3.20.0"		
    echo "--gbm			 google benchmark"		
    echo "--nghttp2-asio		 nghttp2-asio v1.41.0"		
fi
