vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO riddlermichael/rubidium
    REF 792e38aadddbbdb2333a60bbc4b7a01d0855ab65
    SHA512 fddac0cb719fc893dd521be27662c776e97b923d45699d6d476d2c91dee586577c808f57add0f9c13a991c23f42286d85b2998c75c6413a2e8634c1c09fc68a1)

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
