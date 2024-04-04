# Copyright 2022 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cmake_minimum_required (VERSION 3.13)

# CMake invokes the toolchain file twice during the first build, but only once
# during subsequent rebuilds. This was causing the various flags to be added
# twice on the first build, and on a rebuild ninja would see only one set of the
# flags and rebuild the world.
# https://github.com/android-ndk/ndk/issues/323
if(RISCV_TOOLCHAIN_INCLUDED)
  return()
endif(RISCV_TOOLCHAIN_INCLUDED)
set(RISCV_TOOLCHAIN_INCLUDED true)

set(CMAKE_SYSTEM_PROCESSOR riscv)
set(CMAKE_CROSSCOMPILING ON CACHE BOOL "")

if(CMAKE_HOST_SYSTEM_NAME STREQUAL Linux)
  set(RISCV_HOST_TAG linux)
elseif(CMAKE_HOST_SYSTEM_NAME STREQUAL Darwin)
  set(RISCV_HOST_TAG darwin)
endif()

set(RISCV_TOOLCHAIN_NAME clang)

set(CMAKE_C_COMPILER "/usr/bin/clang-17")
set(CMAKE_CXX_COMPILER "/usr/bin/clang++-17")
set(CMAKE_AR "/usr/bin/llvm-ar-17")
set(CMAKE_RANLIB "/usr/bin/llvm-ranlib-17")
set(CMAKE_C_COMPILER_TARGET "riscv32-unknown-elf")
set(CMAKE_CXX_COMPILER_TARGET "riscv32-unknown-elf")

set(RISCV_COMPILER_FLAGS "" CACHE STRING "RISC-V compiler flags for C, CXX, and ASM")
set(RISCV_COMPILER_FLAGS_CXX)
set(RISCV_COMPILER_FLAGS_DEBUG)
set(RISCV_COMPILER_FLAGS_RELEASE)
set(RISCV_LINKER_FLAGS)
set(RISCV_LINKER_FLAGS_EXE)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_C_STANDARD 11)
set(CMAKE_C_EXTENSIONS OFF)     # Force the usage of _ISOC11_SOURCE
set(RISCV_COMPILER_FLAGS "${RISCV_COMPILER_FLAGS} -rtlib=compiler-rt -nostdlib -march=rv32imafdzfh -mabi=ilp32d -mcmodel=medany -ftls-model=local-exec -fno-common")

set(CMAKE_C_FLAGS             "${RISCV_COMPILER_FLAGS} ${CMAKE_C_FLAGS}")
set(CMAKE_CXX_FLAGS           "${RISCV_COMPILER_FLAGS} ${RISCV_COMPILER_FLAGS_CXX} ${CMAKE_CXX_FLAGS}")
set(CMAKE_ASM_FLAGS           "${RISCV_COMPILER_FLAGS} ${CMAKE_ASM_FLAGS}")
set(CMAKE_C_FLAGS_DEBUG       "${RISCV_COMPILER_FLAGS_DEBUG} ${CMAKE_C_FLAGS_DEBUG}")
set(CMAKE_CXX_FLAGS_DEBUG     "${RISCV_COMPILER_FLAGS_DEBUG} ${CMAKE_CXX_FLAGS_DEBUG}")
set(CMAKE_ASM_FLAGS_DEBUG     "${RISCV_COMPILER_FLAGS_DEBUG} ${CMAKE_ASM_FLAGS_DEBUG}")
set(CMAKE_C_FLAGS_RELEASE     "${RISCV_COMPILER_FLAGS_RELEASE} ${CMAKE_C_FLAGS_RELEASE}")
set(CMAKE_CXX_FLAGS_RELEASE   "${RISCV_COMPILER_FLAGS_RELEASE} ${CMAKE_CXX_FLAGS_RELEASE}")
set(CMAKE_ASM_FLAGS_RELEASE   "${RISCV_COMPILER_FLAGS_RELEASE} ${CMAKE_ASM_FLAGS_RELEASE}")
set(CMAKE_SHARED_LINKER_FLAGS "${RISCV_LINKER_FLAGS} ${CMAKE_SHARED_LINKER_FLAGS}")
set(CMAKE_MODULE_LINKER_FLAGS "${RISCV_LINKER_FLAGS} ${CMAKE_MODULE_LINKER_FLAGS}")
set(CMAKE_EXE_LINKER_FLAGS    "${RISCV_LINKER_FLAGS} ${RISCV_LINKER_FLAGS_EXE} ${CMAKE_EXE_LINKER_FLAGS}")
