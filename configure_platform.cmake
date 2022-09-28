################################################################################
# Copyright (C) 2022, NextGIS <info@nextgis.com>
#
# Permission is hereby granted, free of charge, to any person obtaining a
# copy of this software and associated documentation files (the "Software"),
# to deal in the Software without restriction, including without limitation
# the rights to use, copy, modify, merge, publish, distribute, sublicense,
# and/or sell copies of the Software, and to permit persons to whom the
# Software is furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS
# OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
# THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
# FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
# DEALINGS IN THE SOFTWARE.
################################################################################

if("${CMAKE_C_COMPILER_ARCHITECTURE_ID}" STREQUAL "")
    set(HOST_ARCH ${CMAKE_SYSTEM_PROCESSOR})
else()
    set(HOST_ARCH ${CMAKE_C_COMPILER_ARCHITECTURE_ID})
endif()

if("${TARGET_PLATFORM}" STREQUAL "")
    if(HOST_ARCH MATCHES x64|x86_64|AMD64|amd64)
        if(CMAKE_SYSTEM_NAME STREQUAL Windows)
            set(TARGET_PLATFORM X86_WIN64)
        else()
            set(TARGET_PLATFORM X86_64)
        endif()
    elseif(HOST_ARCH MATCHES i.*86.*|X86|x86)
        if(MSVC)
            set(TARGET_PLATFORM X86_WIN32)
        else()
            set(TARGET_PLATFORM X86)
        endif()

        if(CMAKE_SYSTEM_NAME STREQUAL Darwin)
            set(TARGET_PLATFORM X86_DARWIN)
        elseif(CMAKE_SYSTEM_NAME MATCHES FreeBSD|OpenBSD)
            set(TARGET_PLATFORM X86_FREEBSD)
        endif()
    elseif(HOST_ARCH MATCHES aarch64|ARM64|arm64)
        if(MSVC)
            set(TARGET_PLATFORM ARM_WIN64)
        else()
            set(TARGET_PLATFORM AARCH64)
        endif()
    elseif(HOST_ARCH MATCHES arm.*|ARM.*)
        if(MSVC)
            set(TARGET_PLATFORM ARM_WIN32)
        else()
            set(TARGET_PLATFORM ARM)
        endif()
    else()
        message(FATAL_ERROR "Unknown host.")
    endif()
endif()

message(STATUS "Building for TARGET_PLATFORM: ${TARGET_PLATFORM}")
