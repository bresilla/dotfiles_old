#include <fmt/format.h>
#include <cplate/classic.h>
#include <utils.hpp>

int main() {
    std::string s = fmt::format( "I'd rather be {1} than {0}.", "right", "happy" );
    fmt::print( s );    // Python-like format string syntax

    fmt::print( "gogo" );
    fmt::print("something");
    std::cout << 555 << std::endl;

}
