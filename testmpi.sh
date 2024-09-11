#!/bin/bash

function print_help() {
  echo "Usage: $0 [options]"
  echo "Options:"
  echo "  --help Print this help message and exit."
  echo "  --cc <compiler> Set compiler to be used for the build."
  echo "  --cflags <cflags> Set compiler flags for the build."
  echo "  --build-type <Release|Debug> Set build type."
  echo "  --build-dir <build directory> Set build directory."
  echo "  --install-prefix <install prefix> Set install prefix."
}

: ${TESTMPI_CC:=mpicc}
: ${TESTMPI_CFLAGS:=-O3}
: ${TESTMPI_BUILD_TYPE:=RelWithDebInfo}
: ${TESTMPI_BUILD_DIR:=`pwd`/build}
: ${TESTMPI_INSTALL_PREFIX:=`pwd`/install}
: ${TESTMPI_LIB_SUFFIX:=".so"}

while [[ $# -gt 0 ]]; do
  case $1 in
    --help)
      print_help
      exit 0
      ;;
    --cc)
      TESTMPI_CC="$2"
      shift
      shift
      ;;
    --cflags)
      TESTMPI_CFLAGS="$2"
      shift
      shift
      ;;
    --build-type)
      TESTMPI_BUILD_TYPE="$2"
      shift
      shift
      ;;
    --build-dir)
      TESTMPI_BUILD_DIR="$2"
      shift
      shift
      ;;
    --install-prefix)
      TESTMPI_INSTALL_PREFIX="$2"
      shift
      shift
      ;;
    *)
      echo "Error: Unknown option: $1"
      print_help
      exit 1
      ;;
  esac
done

### Don't touch anything that follows this line. ###
if [[ -z "${TESTMPI_CC}" ]]; then
  echo "Error: TESTMPI_CC is not set."
  exit 1
fi

export CC=${TESTMPI_CC}
export CFLAGS="${TESTMPI_CFLAGS}"

TESTMPI_CURRENT_DIR=`pwd`
TESTMPI_CMAKE_CMD="-S ${TESTMPI_CURRENT_DIR}"

if [[ -z "${TESTMPI_BUILD_DIR}" ]]; then
  echo "Error: TESTMPI_BUILD_DIR is not set."
  exit 1
fi
mkdir -p ${TESTMPI_BUILD_DIR} 2> /dev/null
TESTMPI_CMAKE_CMD="${TESTMPI_CMAKE_CMD} -B ${TESTMPI_BUILD_DIR}"

if [[ ! -z "${TESTMPI_BUILD_TYPE}" ]]; then
  TESTMPI_CMAKE_CMD="${TESTMPI_CMAKE_CMD} -DCMAKE_BUILD_TYPE=${TESTMPI_BUILD_TYPE}"
fi
if [[ ! -z "${TESTMPI_INSTALL_PREFIX}" ]]; then
  TESTMPI_CMAKE_CMD="${TESTMPI_CMAKE_CMD} -DCMAKE_INSTALL_PREFIX=${TESTMPI_INSTALL_PREFIX}"
fi

echo "cmake ${TESTMPI_CMAKE_CMD}"
cmake ${TESTMPI_CMAKE_CMD}

cmake --build ${TESTMPI_BUILD_DIR} --target install -j10
