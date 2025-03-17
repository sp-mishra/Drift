cmake_minimum_required(VERSION 3.30)
project(Drift LANGUAGES C CXX)

# Set the default C++ standard to C++23
set(PROJECT_NAME Drift)
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)  # optional, ensure standard is supported
set(CMAKE_CXX_EXTENSIONS OFF)  # optional, keep compiler extensions off
set(CMAKE_C_STANDARD_REQUIRED ON)
set(CMAKE_C_EXTENSIONS OFF)
set(CMAKE_VERBOSE_MAKEFILE ON)
set(BUILD_EXECUTABLE OFF)
set(BUILD_SHARED_LIBS OFF)
set(BUILD_SHARED OFF)

# Spdlog
set(SPDLOG_BUILD_EXAMPLES OFF)
set(SPDLOG_USE_STD_FORMAT ON)
set(SPDLOG_BUILD_SHARED OFF)
set(SPDLOG_ENABLE_PCH ON)
set(SPDLOG_BUILD_EXAMPLE OFF)
set(SPDLOG_BUILD_TESTS OFF)
set(SPDLOG_BUILD_BENCH OFF)


include(FetchContent)
include_directories(/usr/local/include)
include_directories(include)

add_subdirectory(${CMAKE_SOURCE_DIR}/dependencies/spdlog)

#set_target_properties(${PROJECT_NAME} PROPERTIES LINK_SEARCH_START_STATIC ON)
#set_target_properties(${PROJECT_NAME} PROPERTIES LINK_SEARCH_END_STATIC ON)
link_directories(/usr/local/lib)
link_directories("${CMAKE_SOURCE_DIR}/libraries/lib")

add_executable(${PROJECT_NAME} src/main.cpp)

target_link_libraries(${PROJECT_NAME}
                      PRIVATE
                      spdlog::spdlog_header_only
                      )
# Add custom command to increment build number
add_custom_command(
        OUTPUT ${CMAKE_SOURCE_DIR}/include/Version.hpp.tmp
        COMMAND ${CMAKE_SOURCE_DIR}/increment_build_number.sh
        DEPENDS ${CMAKE_SOURCE_DIR}/include/Version.hpp
        COMMENT "Incrementing build number"
        )

add_custom_target(increment_build_number ALL
                  DEPENDS ${CMAKE_SOURCE_DIR}/include/Version.hpp.tmp
                  )

add_dependencies(${PROJECT_NAME} increment_build_number)