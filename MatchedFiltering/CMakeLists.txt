set(MATCHED_FILTER_SOURCES src/main.cpp src/matched_filtering.cu)

# Create the executable target
add_executable(matched_filter ${MATCHED_FILTER_SOURCES})

target_link_libraries(matched_filter PRIVATE CUDA::cudart)

set_target_properties(matched_filter 
    PROPERTIES
    RUNTIME_OUTPUT_DIRECTORY "${CMAKE_SOURCE_DIR}/bin"
)
