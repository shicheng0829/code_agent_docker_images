########### AGGREGATED COMPONENTS AND DEPENDENCIES FOR THE MULTI CONFIG #####################
#############################################################################################

set(cmocka_COMPONENT_NAMES "")
if(DEFINED cmocka_FIND_DEPENDENCY_NAMES)
  list(APPEND cmocka_FIND_DEPENDENCY_NAMES )
  list(REMOVE_DUPLICATES cmocka_FIND_DEPENDENCY_NAMES)
else()
  set(cmocka_FIND_DEPENDENCY_NAMES )
endif()

########### VARIABLES #######################################################################
#############################################################################################
set(cmocka_PACKAGE_FOLDER_RELEASE "/root/.conan2/p/cmock5dc22d090f9ba/p")
set(cmocka_BUILD_MODULES_PATHS_RELEASE "${cmocka_PACKAGE_FOLDER_RELEASE}/lib/cmake/conan-official-cmocka-variables.cmake")


set(cmocka_INCLUDE_DIRS_RELEASE "${cmocka_PACKAGE_FOLDER_RELEASE}/include")
set(cmocka_RES_DIRS_RELEASE )
set(cmocka_DEFINITIONS_RELEASE )
set(cmocka_SHARED_LINK_FLAGS_RELEASE )
set(cmocka_EXE_LINK_FLAGS_RELEASE )
set(cmocka_OBJECTS_RELEASE )
set(cmocka_COMPILE_DEFINITIONS_RELEASE )
set(cmocka_COMPILE_OPTIONS_C_RELEASE )
set(cmocka_COMPILE_OPTIONS_CXX_RELEASE )
set(cmocka_LIB_DIRS_RELEASE "${cmocka_PACKAGE_FOLDER_RELEASE}/lib")
set(cmocka_BIN_DIRS_RELEASE )
set(cmocka_LIBRARY_TYPE_RELEASE STATIC)
set(cmocka_IS_HOST_WINDOWS_RELEASE 0)
set(cmocka_LIBS_RELEASE cmocka)
set(cmocka_SYSTEM_LIBS_RELEASE )
set(cmocka_FRAMEWORK_DIRS_RELEASE )
set(cmocka_FRAMEWORKS_RELEASE )
set(cmocka_BUILD_DIRS_RELEASE )
set(cmocka_NO_SONAME_MODE_RELEASE FALSE)


# COMPOUND VARIABLES
set(cmocka_COMPILE_OPTIONS_RELEASE
    "$<$<COMPILE_LANGUAGE:CXX>:${cmocka_COMPILE_OPTIONS_CXX_RELEASE}>"
    "$<$<COMPILE_LANGUAGE:C>:${cmocka_COMPILE_OPTIONS_C_RELEASE}>")
set(cmocka_LINKER_FLAGS_RELEASE
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,SHARED_LIBRARY>:${cmocka_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,MODULE_LIBRARY>:${cmocka_SHARED_LINK_FLAGS_RELEASE}>"
    "$<$<STREQUAL:$<TARGET_PROPERTY:TYPE>,EXECUTABLE>:${cmocka_EXE_LINK_FLAGS_RELEASE}>")


set(cmocka_COMPONENTS_RELEASE )