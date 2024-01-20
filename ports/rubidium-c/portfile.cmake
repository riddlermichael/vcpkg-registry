vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO riddlermichael/rubidium-c
    REF d01ea0322273aa46e639b4dbf3149dbca01d879d
    SHA512 2bac453fe47605522904e82ff2f5ee563de44964be93c589889684245110501d26994b0a8af509b08fb75c389ac72b2c41e5a8737aeebef04e805b3bb93202bb)

vcpkg_check_features(
    OUT_FEATURE_OPTIONS FEATURE_OPTIONS
    FEATURES
        full-source-location-info FULL_SOURCE_LOCATION_INFO)

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
    CONFIG_PATH lib/cmake/RbC)

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
