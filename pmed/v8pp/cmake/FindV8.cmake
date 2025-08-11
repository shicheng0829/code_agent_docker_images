# Based on https://raw.githubusercontent.com/nicehash/cpp-ethereum/master/cmake/Findv8.cmake
#
# Find the v8 includes and library
#
# This module defines
#  V8_INCLUDE_DIRS, where to find header, etc.
#  V8_LIBRARIES, the libraries needed to use v8.
#  V8_FOUND, If false, do not try to use v8.

if(WIN32)
	set(ARCH ${CMAKE_VS_PLATFORM_TOOLSET_HOST_ARCHITECTURE})
	if(NOT ARCH)
		if(${CMAKE_HOST_SYSTEM_PROCESSOR} STREQUAL "AMD64")
			set(ARCH x64)
		else()
			set(ARCH x86)
		endif()
	endif()

	if(NOT CMAKE_BUILD_TYPE)
		message(WARNING "No CMAKE_BUILD_TYPE set")
	endif()

	set(V8_PACKAGE_NAME v8-v${MSVC_TOOLSET_VERSION}-${ARCH})
	set(V8_PACKAGE_DIRS ${PROJECT_BINARY_DIR} ${PROJECT_SOURCE_DIR} ${PROJECT_SOURCE_DIR}/packages)

	message(STATUS "Looking for ${V8_PACKAGE_NAME} in ${V8_PACKAGE_DIRS}")
	foreach(V8_PACKAGE_DIR ${V8_PACKAGE_DIRS})
		file(GLOB V8_NUGET_DEV_DIR LIST_DIRECTORIES TRUE ${V8_PACKAGE_DIR}/${V8_PACKAGE_NAME}.*)
		if(V8_NUGET_DEV_DIR)
			break()
		endif()
	endforeach()

	if (NOT V8_NUGET_DEV_DIR)
		message(FATAL_ERROR "Not found ${V8_PACKAGE_NAME} in ${V8_PACKAGE_DIRS}")
	else()
		list(GET V8_NUGET_DEV_DIR -1 V8_NUGET_DEV_DIR_LAST)
		set(V8_NUGET_DEV_DIR ${V8_NUGET_DEV_DIR_LAST})
		message(STATUS "Found V8 ${V8_NUGET_DEV_DIR}")
	endif()

	string(REPLACE "v8-" "v8.redist-" V8_NUGET_BIN_DIR ${V8_NUGET_DEV_DIR})

	set(V8_NUGET_INCLUDE_DIR ${V8_NUGET_DEV_DIR}/include)
	set(V8_NUGET_LIB_DIR ${V8_NUGET_DEV_DIR}/lib/${CMAKE_BUILD_TYPE})
	set(V8_NUGET_BIN_DIR ${V8_NUGET_BIN_DIR}/lib/${CMAKE_BUILD_TYPE})

	find_file(V8_DLL v8.dll ${V8_NUGET_BIN_DIR})
	find_file(V8_LIBPLATFORMDLL v8_libplatform.dll ${V8_NUGET_BIN_DIR})

	file(GLOB V8_BINARIES ${V8_NUGET_BIN_DIR}/*)
	message(STATUS "Copy ${V8_BINARIES} to the project output dir ${CMAKE_RUNTIME_OUTPUT_DIRECTORY}")
	file(COPY ${V8_BINARIES} DESTINATION ${CMAKE_RUNTIME_OUTPUT_DIRECTORY})
endif()

# 在Linux上查找V8头文件和库
if(NOT WIN32)
	# 查找V8头文件
	find_path(V8_INCLUDE_DIR v8.h
		PATHS /usr/include/v8 /usr/include/node/v8 /usr/include/nodejs/deps/v8/include
		NO_DEFAULT_PATH
	)

	# 如果没找到，使用系统默认路径
	if(NOT V8_INCLUDE_DIR)
		find_path(V8_INCLUDE_DIR v8.h)
	endif()

	# 查找V8库
	find_library(V8_LIBRARY v8)
	find_library(V8_LIBPLATFORM_LIBRARY v8_libplatform)

	# 设置变量
	set(V8_INCLUDE_DIRS ${V8_INCLUDE_DIR})
	set(V8_LIBRARIES ${V8_LIBRARY} ${V8_LIBPLATFORM_LIBRARY})
else()
	# Windows上的原有逻辑
	find_path(V8_INCLUDE_DIRS PATHS ${V8_NUGET_INCLUDE_DIR} PATH_SUFFIXES v8 NAMES v8.h)
	find_library(V8_LIB PATHS ${V8_NUGET_LIB_DIR} NAMES v8 v8.dll.lib)
	find_library(V8_LIBPLATFORM PATHS ${V8_NUGET_LIB_DIR} NAMES v8_libplatform v8_libplatform.dll.lib)
endif()

# handle the QUIETLY and REQUIRED arguments and set V8_FOUND to TRUE
# if all listed variables are TRUE, hide their existence from configuration view
include(FindPackageHandleStandardArgs)

if(NOT WIN32)
	find_package_handle_standard_args(V8 DEFAULT_MSG V8_INCLUDE_DIRS V8_LIBRARIES)
	mark_as_advanced(V8_INCLUDE_DIRS V8_LIBRARIES)
else()
	find_package_handle_standard_args(V8 DEFAULT_MSG V8_INCLUDE_DIRS V8_LIB V8_LIBPLATFORM)
	mark_as_advanced(V8_INCLUDE_DIRS V8_LIB)
endif()

if(V8_FOUND)
	if(NOT WIN32)
		# Linux上的处理
		add_library(V8::v8 UNKNOWN IMPORTED)
		set_target_properties(V8::v8 PROPERTIES
			INTERFACE_INCLUDE_DIRECTORIES "${V8_INCLUDE_DIRS}"
			IMPORTED_LOCATION "${V8_LIBRARIES}")

		# 创建别名目标
		if(NOT TARGET V8::V8)
			add_library(V8::V8 ALIAS V8::v8)
		endif()
	else()
		# Windows上的原有逻辑
		add_library(V8::v8 SHARED IMPORTED)
		add_library(V8::libplatform SHARED IMPORTED)
		if(WIN32)
			set_target_properties(V8::v8 PROPERTIES
				IMPORTED_IMPLIB ${V8_LIB} IMPORTED_LOCATION ${V8_DLL})
			set_target_properties(V8::libplatform PROPERTIES
				IMPORTED_IMPLIB ${V8_LIBPLATFORM} IMPORTED_LOCATION ${V8_LIBPLATFORMDLL})
		else()
			set_target_properties(V8::v8 PROPERTIES IMPORTED_LOCATION ${V8_LIB})
			set_target_properties(V8::libplatform PROPERTIES IMPORTED_LOCATION ${V8_LIBPLATFORM})
		endif()
		target_include_directories(V8::v8 INTERFACE ${V8_INCLUDE_DIRS})
		target_include_directories(V8::libplatform INTERFACE ${V8_INCLUDE_DIRS})
		target_link_libraries(V8::v8 INTERFACE V8::libplatform)

		# 确保V8::V8别名目标存在
		if(NOT TARGET V8::V8)
			add_library(V8::V8 ALIAS V8::v8)
		endif()
	endif()
endif()