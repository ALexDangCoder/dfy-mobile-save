# Install script for directory: /Users/hoang/dfy-mobile

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "0")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "TRUE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE STATIC_LIBRARY FILES "/Users/hoang/dfy-mobile/android/trustwalletcore/.cxx/cmake/debug/x86_64/libprotobuf.a")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/protobuf" TYPE FILE FILES
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/any.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/any.pb.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/api.pb.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/arena.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/arenastring.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/compiler/importer.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/compiler/parser.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/descriptor.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/descriptor.pb.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/descriptor_database.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/duration.pb.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/dynamic_message.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/empty.pb.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/extension_set.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/field_mask.pb.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/generated_message_reflection.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/generated_message_util.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/implicit_weak_message.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/io/coded_stream.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/io/gzip_stream.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/io/printer.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/io/strtod.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/io/tokenizer.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/io/zero_copy_stream.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/io/zero_copy_stream_impl.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/io/zero_copy_stream_impl_lite.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/map_field.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/message.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/message_lite.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/parse_context.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/reflection_ops.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/repeated_field.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/service.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/source_context.pb.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/struct.pb.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/stubs/bytestream.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/stubs/common.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/stubs/int128.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/stubs/once.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/stubs/status.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/stubs/statusor.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/stubs/stringpiece.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/stubs/stringprintf.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/stubs/strutil.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/stubs/substitute.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/stubs/time.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/text_format.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/timestamp.pb.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/type.pb.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/unknown_field_set.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/delimited_message_util.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/field_comparator.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/field_mask_util.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/datapiece.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/default_value_objectwriter.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/error_listener.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/field_mask_utility.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/json_escaping.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/json_objectwriter.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/json_stream_parser.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/object_writer.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/proto_writer.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/protostream_objectsource.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/protostream_objectwriter.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/type_info.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/type_info_test_helper.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/internal/utility.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/json_util.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/message_differencer.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/time_util.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/util/type_resolver_util.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/wire_format.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/wire_format_lite.h"
    "/Users/hoang/dfy-mobile/build/local/src/protobuf/protobuf-3.14.0/src/google/protobuf/wrappers.pb.h"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib" TYPE SHARED_LIBRARY FILES "/Users/hoang/dfy-mobile/build/trustwalletcore/intermediates/cmake/debug/obj/x86_64/libTrustWalletCore.so")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libTrustWalletCore.so" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libTrustWalletCore.so")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Users/hoang/Library/Android/sdk/ndk/21.2.6472646/toolchains/llvm/prebuilt/darwin-x86_64/bin/x86_64-linux-android-strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/lib/libTrustWalletCore.so")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include/WalletCore" TYPE DIRECTORY FILES "/Users/hoang/dfy-mobile/src/" FILES_MATCHING REGEX "/[^/]*\\.h$")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/Users/hoang/dfy-mobile/include/")
endif()

if(NOT CMAKE_INSTALL_LOCAL_ONLY)
  # Include the install script for each subdirectory.
  include("/Users/hoang/dfy-mobile/android/trustwalletcore/.cxx/cmake/debug/x86_64/trezor-crypto/cmake_install.cmake")

endif()

if(CMAKE_INSTALL_COMPONENT)
  set(CMAKE_INSTALL_MANIFEST "install_manifest_${CMAKE_INSTALL_COMPONENT}.txt")
else()
  set(CMAKE_INSTALL_MANIFEST "install_manifest.txt")
endif()

string(REPLACE ";" "\n" CMAKE_INSTALL_MANIFEST_CONTENT
       "${CMAKE_INSTALL_MANIFEST_FILES}")
file(WRITE "/Users/hoang/dfy-mobile/android/trustwalletcore/.cxx/cmake/debug/x86_64/${CMAKE_INSTALL_MANIFEST}"
     "${CMAKE_INSTALL_MANIFEST_CONTENT}")
