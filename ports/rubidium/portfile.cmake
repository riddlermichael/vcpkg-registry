vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO riddlermichael/rubidium
    REF 4fcc319ecc78697c28b1c90dfdcd6f333b07e02d
    SHA512 6e21ec2607676ce8a6d3ddd2f368e1bc1804febccc21300aa04b88e8d805e60a3906bdef4af3063c6d129375d619cfb88de06472060f17c8f9697a7918d0979c)

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
        -DBUILD_DOC=OFF
        -DBUILD_EXAMPLES=OFF
        -DBUILD_TESTING=OFF
    MAYBE_UNUSED_VARIABLES
        BUILD_EXAMPLES)

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
