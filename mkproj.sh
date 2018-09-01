#!/bin/sh

# Author: Carl F
# Purpose: Create an empty C/C++ CMake project structure
# Date: 23.08.2018

# Ensure a parameter is present
if [ $# -ne 1 ]; then
        echo "Usage: mkproj <projName>"
        exit 0
fi

mkdir $1
mkdir $1/$1
mkdir $1/$1/include
mkdir $1/$1/src
touch $1/$1/CMakeLists.txt
echo "# $1 CMakeLists

# Required CMake Version
cmake_minimum_required(VERSION 3.9 REQUIRED)

# Define project
project($1 VERSION 0.0.0 LANGUAGES C/CXX)

# Cpp Standard
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_subdirectory($1)
" > $1/CMakeLists.txt

