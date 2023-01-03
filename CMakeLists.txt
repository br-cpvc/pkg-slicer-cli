cmake_minimum_required(VERSION 2.8...3.25.1)
project(slicer-cli)


set(SlicerExecutionModel_DIR "output/SlicerExecutionModel/build")

# from: https://www.slicer.org/wiki/Documentation/Nightly/Developers/SlicerExecutionModel#Using_GenerateCLP
find_package(SlicerExecutionModel REQUIRED)
include(${SlicerExecutionModel_USE_FILE})

# TODO: according to the docs this should not be needed
include(${GenerateCLP_USE_FILE})

set(OrientScalarVolume_SOURCE deps/Slicer/Modules/CLI/OrientScalarVolume/OrientScalarVolume.cxx)
GENERATECLP(OrientScalarVolume_SOURCE ${CMAKE_SOURCE_DIR}/deps/Slicer/Modules/CLI/OrientScalarVolume/OrientScalarVolume.xml)


FIND_PACKAGE(ITK)
include(${ITK_USE_FILE})
INCLUDE_DIRECTORIES(${ITK_INCLUDE_DIRS} "deps/Slicer/Base/CLI/" "deps/SlicerExecutionModel/ModuleDescriptionParser/")
ADD_EXECUTABLE(OrientScalarVolume ${OrientScalarVolume_SOURCE})
TARGET_LINK_LIBRARIES(OrientScalarVolume ${ITK_LIBRARIES})

INSTALL(TARGETS OrientScalarVolume DESTINATION bin/)
