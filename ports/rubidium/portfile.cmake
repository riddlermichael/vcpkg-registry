vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO riddlermichael/rubidium
    REF 24c14e9994d864238de37abc2448906a1b05ba31
    SHA512 f22a7270ba7353e83bee72224a81fc30a4151c4e2ea7fa516fab4cf7da41de1e0d65fe37c85405bfbbc026ade81c8a473b5f1fdff5d7dfb8f6beb24127f518ff)

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
