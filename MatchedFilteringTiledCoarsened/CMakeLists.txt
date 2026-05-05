set(COARSENED_SOURCES src/main.cpp src/matched_filtering.cu)

# Create the executable target
add_executable(matched_filter_tiled_coarsened ${COARSENED_SOURCES})

target_link_libraries(matched_filter_tiled_coarsened PRIVATE CUDA::cudart)

set_target_properties(matched_filter_tiled_coarsened 
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin"
)
