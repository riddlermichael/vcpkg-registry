vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO riddlermichael/rubidium
    REF eb56eb483f15fcfce72ca98e10e14341ff394894
    SHA512 25d5f4a7ae6a5cb12b04a233c2403ef58b22d54609b19153993730b5e7f07c7f607c4fe27cda8cf2ba718db922d5a3f8b9c782c18adf0b7f8a0c026691593e84)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        duration-has-nan DURATION_HAS_NAN
        full-source-location-info FULL_SOURCE_LOCATION_INFO
        time-v2 TIME_V2)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
        -DBUILD_TESTING=OFF
        -DBUILD_DOC=OFF
        -DBUILD_EXAMPLES=OFF)

vcpkg_cmake_install()

vcpkg_cmake_config_fixup(
    PACKAGE_NAME RbC
    CONFIG_PATH lib/cmake/RbC
    DO_NOT_DELETE_PARENT_CONFIG_PATH)
vcpkg_cmake_config_fixup(
    PACKAGE_NAME Rb
    CONFIG_PATH lib/cmake/Rb
    DO_NOT_DELETE_PARENT_CONFIG_PATH)

file(REMOVE_RECURSE
    "${CURRENT_PACKAGES_DIR}/debug/include"
    "${CURRENT_PACKAGES_DIR}/debug/lib/cmake"
    "${CURRENT_PACKAGES_DIR}/lib/cmake")

file(INSTALL "${SOURCE_PATH}/LICENSE"
    DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
    RENAME copyright)

configure_file(
    "${CMAKE_CURRENT_LIST_DIR}/usage"
    "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage"
    COPYONLY)
