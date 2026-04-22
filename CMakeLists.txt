# Root CMakeLists.txt
cmake_minimum_required(VERSION 3.18 FATAL_ERROR)

project(MatchedFiltering LANGUAGES CXX CUDA)

set(CMAKE_CUDA_FLAGS "${CMAKE_CUDA_FLAGS} -allow-unsupported-compiler")

# Set C++ standard for all targets
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)
set(CMAKE_CXX_EXTENSIONS OFF)

# Find CUDA
find_package(CUDAToolkit REQUIRED)

add_subdirectory(MatchedFiltering)
