########## MACROS ###########################################################################
#############################################################################################

# Requires CMake > 3.15
if(${CMAKE_VERSION} VERSION_LESS "3.15")
    message(FATAL_ERROR "The 'CMakeDeps' generator only works with CMake >= 3.15")
endif()

if(cmocka_FIND_QUIETLY)
    set(cmocka_MESSAGE_MODE VERBOSE)
else()
    set(cmocka_MESSAGE_MODE STATUS)
endif()

include(${CMAKE_CURRENT_LIST_DIR}/cmakedeps_macros.cmake)
include(${CMAKE_CURRENT_LIST_DIR}/cmockaTargets.cmake)
include(CMakeFindDependencyMacro)

check_build_type_defined()

foreach(_DEPENDENCY ${cmocka_FIND_DEPENDENCY_NAMES} )
    # Check that we have not already called a find_package with the transitive dependency
    if(NOT ${_DEPENDENCY}_FOUND)
        find_dependency(${_DEPENDENCY} REQUIRED ${${_DEPENDENCY}_FIND_MODE})
    endif()
endforeach()

set(cmocka_VERSION_STRING "1.1.7")
set(cmocka_INCLUDE_DIRS ${cmocka_INCLUDE_DIRS_RELEASE} )
set(cmocka_INCLUDE_DIR ${cmocka_INCLUDE_DIRS_RELEASE} )
set(cmocka_LIBRARIES ${cmocka_LIBRARIES_RELEASE} )
set(cmocka_DEFINITIONS ${cmocka_DEFINITIONS_RELEASE} )


# Only the last installed configuration BUILD_MODULES are included to avoid the collision
foreach(_BUILD_MODULE ${cmocka_BUILD_MODULES_PATHS_RELEASE} )
    message(${cmocka_MESSAGE_MODE} "Conan: Including build module from '${_BUILD_MODULE}'")
    include(${_BUILD_MODULE})
endforeach()


