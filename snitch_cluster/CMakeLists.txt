
add_library(snitchSetup stubs.cpp)
target_link_libraries(snitchSetup PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/libsnRuntime.a)
target_link_options(snitchSetup PUBLIC -T${CMAKE_CURRENT_SOURCE_DIR}/sw/snRuntime/base.ld)
target_link_directories(snitchSetup PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/target/snitch_cluster/sw/runtime/rtl-generic)
