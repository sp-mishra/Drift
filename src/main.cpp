#include <iostream>
#include "Log.hpp"
#include "Version.hpp"

namespace gk = groklab;

int main() {
    gk::info("Hello, World!. Build Verson: {}", DRIFT_BUILD_NUMBER);
    return 0;
}