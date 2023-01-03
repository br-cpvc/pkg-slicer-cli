#!/usr/bin/env bash
set -e
#set -x
script_dir=$(dirname "$0")
cwd=`pwd`

old_method=true
if [[ "$old_method" == true ]]; then
    # use a hardcoded version of itk, downloaded
    # as a tar ball and compiled from source
    #itk_version="4.5.0"
    #itk_version="4.7.2"
    itk_version=4.8.2
    itk_version=5.3.0
    itk_dir_prefix="InsightToolkit"
    outputdir=$2
    source ${script_dir}/dwn_itk.sh $itk_dir_prefix $itk_version $outputdir

    itk_dir="$outputdir/$itk_dir_prefix-$itk_version"
else
    # use git submodule checkout version of itk,
    # needs to have added itk as git submodule deps/ITK
    itk_dir="deps/ITK"
fi

# build dependencies
build_script=$1
source $build_script $itk_dir

# remove the 'itk::PluginFilterWatcherCLPProcessInformation...CLPProcessInformation);''
# lines, which spams xml filter communication to std out.
# -z matches multiple lines as one, [^/]* chooses the shortest match
sed -zi "s/  itk::PluginFilterWatcher[^/]*CLPProcessInformation);\n//g" deps/Slicer/Modules/CLI/OrientScalarVolume/OrientScalarVolume.cxx

mkdir -p $outputdir/SlicerExecutionModel/build
cd $outputdir/SlicerExecutionModel/build
cmake $cwd/deps/SlicerExecutionModel/ \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_C_COMPILER=/usr/bin/gcc-11 \
-DCMAKE_CXX_COMPILER=/usr/bin/g++-11 \
-DITK_DIR=$cwd/$itk_dir/build \
-DCMAKE_CXX_FLAGS="-fopenmp -std=c++11 -fpermissive" \
-DCMAKE_EXE_LINKER_FLAGS="-static" \
-DBUILD_SHARED_LIBS:BOOL=OFF \
-DCMAKE_FIND_LIBRARY_SUFFIXES=".a"
sh ${script_dir}/make.sh
cd $cwd

# this has been replaced by the cmake commands described in: https://www.slicer.org/wiki/Documentation/Nightly/Developers/SlicerExecutionModel#Using_GenerateCLP
#./output/SlicerExecutionModel/build/GenerateCLP/bin/GenerateCLP --InputXML deps/Slicer/Modules/CLI/OrientScalarVolume/OrientScalarVolume.xml --OutputCxx output/build/OrientScalarVolumeCLP.h #deps/Slicer/Modules/CLI/OrientScalarVolume/OrientScalarVolumeCLP.h

mkdir -p $outputdir/build
cd $outputdir/build
cmake $cwd/ \
-DCMAKE_INSTALL_PREFIX=../install \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_C_COMPILER=/usr/bin/gcc-11 \
-DCMAKE_CXX_COMPILER=/usr/bin/g++-11 \
-DITK_DIR=$cwd/$itk_dir/build \
-DCMAKE_CXX_FLAGS="-fopenmp -std=c++11 -fpermissive" \
-DCMAKE_EXE_LINKER_FLAGS="-static" \
-DBUILD_SHARED_LIBS:BOOL=OFF \
-DCMAKE_FIND_LIBRARY_SUFFIXES=".a"

# see: https://www.kitware.com/creating-static-executables-on-linux/

sh ${script_dir}/make.sh
cd $cwd
