# Cpp-Dev-Environment-Installer
Simple C++ Developement environment installer including boost and nghttp2 libraries

The packages installed in this setup are listed below:

- gcc-8 & g++-8
- make 
- cmake (v3.20)
- git
- google benchmark
- boost-all (v1.75.0)
- nghttp2 (v1.41.0)

__Install packages by:__

    ./simple_cpp_environment.sh --all

__Package spesific installation:__  
    see. ./simple_cpp_environment.sh __--help__

    --gxx			 gcc-8 && g++-compiler		
    --make			 make		
    --boost			 boost-1.75.0		
    --no_boost		 Install all libs except boost and nghttp2		
    --git			 git latest version		
    --cmake			 Cmake-3.20.0		
    --gbm			 google benchmark		
    --nghttp2-asio		 nghttp2-asio v1.41.0		  

    