FROM ubuntu:22.04
RUN apt-get update -y && DEBIAN_FRONTEND=noninteractive apt-get install -y git make g++-11 fakeroot wget

ADD https://github.com/Kitware/CMake/releases/download/v3.25.1/cmake-3.25.1-linux-x86_64.tar.gz cmake.tar.gz
RUN tar xzf /cmake.tar.gz --directory=/usr/ --strip-components=1
