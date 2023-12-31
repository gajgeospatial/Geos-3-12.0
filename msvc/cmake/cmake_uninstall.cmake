#################################################################################
#
# This file is a part of CMake build configuration of GEOS library
#
# Defines commands used by make uninstall target of CMake build configuration.
#
# Author: Credit to the CMake mailing list archives for providing this solution.
# Modifications: Mateusz Loskot <mateusz@loskot.net>
#
#################################################################################
if(NOT EXISTS "N:/Development/Dev_Base/geos-3.12.0/msvc/install_manifest.txt")
  message(FATAL_ERROR
    "Cannot find install manifest:
    N:/Development/Dev_Base/geos-3.12.0/msvc/install_manifest.txt")
endif()

file(READ "N:/Development/Dev_Base/geos-3.12.0/msvc/install_manifest.txt" files)
string(REGEX REPLACE "\n" ";" files "${files}")

set(GEOS_INCLUDE_DIR)
foreach(file ${files})

  if(${file} MATCHES "geom.h")
    get_filename_component(GEOS_INCLUDE_DIR ${file} PATH)
  endif()

  message(STATUS "Uninstalling $ENV{DESTDIR}${file}")
  if(NOT EXISTS "$ENV{DESTDIR}${file}")
    message(STATUS "File \"$ENV{DESTDIR}${file}\" does not exist.")
    message(STATUS "\tTrying to execute remove command anyway.")
  endif()

  exec_program("C:/Program Files/CMake/bin/cmake.exe" ARGS "-E remove \"$ENV{DESTDIR}${file}\""
    OUTPUT_VARIABLE rm_out
    RETURN_VALUE rm_retval)
  if(NOT "${rm_retval}" STREQUAL 0)
    message(FATAL_ERROR "Problem when removing \"$ENV{DESTDIR}${file}\"")
  endif()
endforeach()

message(STATUS "Deleting ${GEOS_INCLUDE_DIR} directory")
exec_program("C:/Program Files/CMake/bin/cmake.exe"
  ARGS "-E remove_directory \"${GEOS_INCLUDE_DIR}\""
  OUTPUT_VARIABLE rm_out
  RETURN_VALUE rm_retval)
if(NOT "${rm_retval}" STREQUAL 0)
  message(FATAL_ERROR "Problem when removing \"${GEOS_INCLUDE_DIR}\"")
endif()
