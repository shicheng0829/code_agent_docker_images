# Avoid multiple calls to find_package to append duplicated properties to the targets
include_guard()########### VARIABLES #######################################################################
#############################################################################################
set(cmocka_FRAMEWORKS_FOUND_RELEASE "") # Will be filled later
conan_find_apple_frameworks(cmocka_FRAMEWORKS_FOUND_RELEASE "${cmocka_FRAMEWORKS_RELEASE}" "${cmocka_FRAMEWORK_DIRS_RELEASE}")

set(cmocka_LIBRARIES_TARGETS "") # Will be filled later


######## Create an interface target to contain all the dependencies (frameworks, system and conan deps)
if(NOT TARGET cmocka_DEPS_TARGET)
    add_library(cmocka_DEPS_TARGET INTERFACE IMPORTED)
endif()

set_property(TARGET cmocka_DEPS_TARGET
             APPEND PROPERTY INTERFACE_LINK_LIBRARIES
             $<$<CONFIG:Release>:${cmocka_FRAMEWORKS_FOUND_RELEASE}>
             $<$<CONFIG:Release>:${cmocka_SYSTEM_LIBS_RELEASE}>
             $<$<CONFIG:Release>:>)

####### Find the libraries declared in cpp_info.libs, create an IMPORTED target for each one and link the
####### cmocka_DEPS_TARGET to all of them
conan_package_library_targets("${cmocka_LIBS_RELEASE}"    # libraries
                              "${cmocka_LIB_DIRS_RELEASE}" # package_libdir
                              "${cmocka_BIN_DIRS_RELEASE}" # package_bindir
                              "${cmocka_LIBRARY_TYPE_RELEASE}"
                              "${cmocka_IS_HOST_WINDOWS_RELEASE}"
                              cmocka_DEPS_TARGET
                              cmocka_LIBRARIES_TARGETS  # out_libraries_targets
                              "_RELEASE"
                              "cmocka"    # package_name
                              "${cmocka_NO_SONAME_MODE_RELEASE}")  # soname

# FIXME: What is the result of this for multi-config? All configs adding themselves to path?
set(CMAKE_MODULE_PATH ${cmocka_BUILD_DIRS_RELEASE} ${CMAKE_MODULE_PATH})

########## GLOBAL TARGET PROPERTIES Release ########################################
    set_property(TARGET cmocka::cmocka
                 APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                 $<$<CONFIG:Release>:${cmocka_OBJECTS_RELEASE}>
                 $<$<CONFIG:Release>:${cmocka_LIBRARIES_TARGETS}>
                 )

    if("${cmocka_LIBS_RELEASE}" STREQUAL "")
        # If the package is not declaring any "cpp_info.libs" the package deps, system libs,
        # frameworks etc are not linked to the imported targets and we need to do it to the
        # global target
        set_property(TARGET cmocka::cmocka
                     APPEND PROPERTY INTERFACE_LINK_LIBRARIES
                     cmocka_DEPS_TARGET)
    endif()

    set_property(TARGET cmocka::cmocka
                 APPEND PROPERTY INTERFACE_LINK_OPTIONS
                 $<$<CONFIG:Release>:${cmocka_LINKER_FLAGS_RELEASE}>)
    set_property(TARGET cmocka::cmocka
                 APPEND PROPERTY INTERFACE_INCLUDE_DIRECTORIES
                 $<$<CONFIG:Release>:${cmocka_INCLUDE_DIRS_RELEASE}>)
    # Necessary to find LINK shared libraries in Linux
    set_property(TARGET cmocka::cmocka
                 APPEND PROPERTY INTERFACE_LINK_DIRECTORIES
                 $<$<CONFIG:Release>:${cmocka_LIB_DIRS_RELEASE}>)
    set_property(TARGET cmocka::cmocka
                 APPEND PROPERTY INTERFACE_COMPILE_DEFINITIONS
                 $<$<CONFIG:Release>:${cmocka_COMPILE_DEFINITIONS_RELEASE}>)
    set_property(TARGET cmocka::cmocka
                 APPEND PROPERTY INTERFACE_COMPILE_OPTIONS
                 $<$<CONFIG:Release>:${cmocka_COMPILE_OPTIONS_RELEASE}>)

########## For the modules (FindXXX)
set(cmocka_LIBRARIES_RELEASE cmocka::cmocka)
