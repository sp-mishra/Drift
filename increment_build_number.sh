#!/bin/bash

# Function to increment the build number
increment_build_number() {
  VERSION_FILE="$(dirname "$0")/include/Version.hpp"
  BUILD_NUMBER=$(grep "#define DRIFT_BUILD_NUMBER" $VERSION_FILE | awk '{print $3}')
  NEW_BUILD_NUMBER=$((BUILD_NUMBER + 1))

  sed -i '' "s/#define DRIFT_BUILD_NUMBER $BUILD_NUMBER/#define DRIFT_BUILD_NUMBER $NEW_BUILD_NUMBER/" $VERSION_FILE

  echo "Updated DRIFT_BUILD_NUMBER to $NEW_BUILD_NUMBER"
}

increment_build_number