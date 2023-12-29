vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

set(AUTHORIZATION_TOKEN
    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)
#vcpkg_from_git(
#    OUT_SOURCE_PATH SOURCE_PATH
#    URL https://github.com/riddlermichael/rubidium.git
#    REF e792e13f90a6f974d472e7967386fea5010f5c4f
#    HEAD_REF master
#)
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO riddlermichael/rubidium
    REF master
    SHA512 0e64ecfe89a9c0b0b1e0447cf56f0b9685b66acea8a4244e203021f493b2937c0813791b0d5fbe502f2323214ed222b0dc6fc244a6ec1819bb62eb72ca1e40c6
#    AUTHORIZATION_TOKEN ${AUTHORIZATION_TOKEN}
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
    -DBUILD_TESTING=OFF
    -DBUILD_DOC=OFF
    -DBUILD_EXAMPLES=OFF
)

vcpkg_cmake_install()

#vcpkg_cmake_config_fixup(PACKAGE_NAME "rubidium")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")

# file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
# configure_file("${CMAKE_CURRENT_LIST_DIR}/usage" "${CURRENT_PACKAGES_DIR}/share/${PORT}/usage" COPYONLY)
