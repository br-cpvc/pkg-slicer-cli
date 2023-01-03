cmake_minimum_required(VERSION 2.8...3.25.1)
project(slicer-cli)

FIND_PACKAGE(ITK)
include(${ITK_USE_FILE})
INCLUDE_DIRECTORIES(${ITK_INCLUDE_DIRS} "deps/Slicer/Base/CLI/" "deps/SlicerExecutionModel/ModuleDescriptionParser/" ".")
ADD_EXECUTABLE(OrientScalarVolume deps/Slicer/Modules/CLI/OrientScalarVolume/OrientScalarVolume.cxx)
TARGET_LINK_LIBRARIES(OrientScalarVolume ${ITK_LIBRARIES})

INSTALL(TARGETS OrientScalarVolume DESTINATION bin/)
