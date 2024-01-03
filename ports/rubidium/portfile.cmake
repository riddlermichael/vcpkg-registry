vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO riddlermichael/rubidium
    REF 861f5d5fcca5de56b4b63058462b399175efab7b
    SHA512 c1d998be2b329af9691d815685310492e0721342117c5d5ece4fee3b4f91900590d73c7347d6282d467798ab6f1143b648e8d30d24bc59392735c2fe0a9e7f4a)

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
