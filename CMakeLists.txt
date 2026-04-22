# Root CMakeLists.txt
cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

include(FetchContent)
include(ExternalProject)

# Allow the user to specify a desired compiler version and install path
set(USER_SPECIFIED_C_COMPILER "" CACHE STRING "User-specified C compiler")
set(USER_SPECIFIED_CXX_COMPILER "" CACHE STRING "User-specified C++ compiler")

# Set compilers before project declaration
if(NOT "${USER_SPECIFIED_CXX_COMPILER}" STREQUAL "")
    set(CMAKE_CXX_COMPILER "${USER_SPECIFIED_CXX_COMPILER}")
endif()

if(NOT "${USER_SPECIFIED_C_COMPILER}" STREQUAL "")
    set(CMAKE_C_COMPILER "${USER_SPECIFIED_C_COMPILER}")
endif()

# Set CUDA flags before project declaration
set(CMAKE_CUDA_COMPILER_FLAGS "-allow-unsupported-compiler")
set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -allow-unsupported-compiler")
if(NOT "${USER_SPECIFIED_C_COMPILER}" STREQUAL "")
    set(CMAKE_CUDA_HOST_COMPILER "${USER_SPECIFIED_C_COMPILER}")
endif()

project(cuda_projects LANGUAGES CXX CUDA)

# Set C++ standard for all targets
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Find CUDA
find_package(CUDA REQUIRED)
find_package(CUDAToolkit REQUIRED)
