#
# This file sets some defaults from your *source* directory, such that
# for each build directory you create, the same defaults are used.
#

#
# BIG WARNING :
#
# DO NOT EDIT THIS FILE ! Instead: copy it to orocos-rtt.cmake (in the
# top source directory) and edit that file to set your defaults.
#
# ie: cp orocos-rtt.default.cmake orocos-rtt.cmake ; edit orocos-rtt.cmake
#
# It will be included by the build system, right after the compiler has been
# detected (see top level CMakeLists.txt file)

#
# BIG WARNING :
#
# This is *NOT* a CMake Toolchain file. See http://www.paraview.org/Wiki/CMake_Cross_Compiling
# on how to create and one. This file is included *too late* in the cmake process
# to function correctly as a toolchain file. ESPECIALLY: don't set a compiler
# in this file, this will reset all your cached settings. Do not use this
# file to setup a cross-compilation environment.

#
# Uncomment to set additional include and library paths for: 
# Boost, Xerces, TAO, Omniorb etc.
# The example below is for win32 targets.
# 
# NOTE THE MANDATORY '/' instead of '\' on win32 platforms !
#
set(CMAKE_INCLUDE_PATH ${CMAKE_INCLUDE_PATH} "/home/sambeet/NewRockPort/x86/Install/boost/include/boost")
# set(CMAKE_LIBRARY_PATH ${CMAKE_LIBRARY_PATH} "C:/orocos/Boost-1_36_0/lib")

#
# Sets the CMAKE_BUILD_TYPE to Release by default. This is not a normal
# CMake flag which is not readable during configuration time.
if (NOT CMAKE_BUILD_TYPE)
  set(CMAKE_BUILD_TYPE RelWithDebInfo CACHE STRING "Choose the type of build, options are: None(CMAKE_CXX_FLAGS or CMAKE_C_FLAGS used) Debug Release RelWithDebInfo MinSizeRel." FORCE)
endif()

#
# An option to make it easy to turn off all tests (defaults to ON)
#
# option( BUILD_TESTING "Turn me off to disable compilation of all tests" OFF )

#
# OFF: SHARED  ON: SHARED AND STATIC (defaults to OFF)
#
# set(FORCE_BUILD_STATIC ON)

#
# Set the target operating system. One of [lxrt gnulinux xenomai macosx rtems win32]
# You may leave this as-is or force a certain target by removing the if... logic.
#
set(DOC_STRING "The Operating System target. One of [gnulinux lxrt macosx rtems win32 xenomai ]")
set(OROCOS_TARGET_ENV $ENV{OROCOS_TARGET}) # MUST use helper variable, otherwise not picked up !!!
if( OROCOS_TARGET_ENV )
  set(OROCOS_TARGET ${OROCOS_TARGET_ENV} CACHE STRING "${DOC_STRING}" FORCE)
  message( "Detected OROCOS_TARGET environment variable. Using: ${OROCOS_TARGET}")
else()
  if(NOT DEFINED OROCOS_TARGET )
    if(MSVC)
      set(OROCOS_TARGET win32    CACHE STRING "${DOC_STRING}")
    elseif(APPLE AND ${CMAKE_SYSTEM_NAME} MATCHES "Darwin")
      set(OROCOS_TARGET macosx   CACHE STRING "${DOC_STRING}")
    else()
      set(OROCOS_TARGET gnulinux CACHE STRING "${DOC_STRING}")
    endif()
  endif()
  message( "No OROCOS_TARGET environment variable set. Using: ${OROCOS_TARGET}")
endif()

# Useful for Windows/MSVC builds, sets all libraries and executables in one place.
#
# Uncomment to let output go to bin/ and libs/
#
# set(EXECUTABLE_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/bin CACHE PATH "Bin directory")
# set(LIBRARY_OUTPUT_PATH ${CMAKE_CURRENT_SOURCE_DIR}/libs CACHE PATH "Lib directory")
#
# And additional link directories.
#
# LINK_DIRECTORIES( ${CMAKE_CURRENT_SOURCE_DIR}/libs )






