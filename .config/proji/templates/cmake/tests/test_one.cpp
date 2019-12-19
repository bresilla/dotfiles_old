#define DOCTEST_CONFIG_IMPLEMENT_WITH_MAIN
#include <cplate/classic.h>
#include <utils.hpp>
#include <doctest.hpp>

TEST_CASE( "testing the factorial function" ) {
    CHECK( utl::factorial( 1 ) == 1 );
    CHECK( utl::factorial( 2 ) == 2 );
    CHECK( utl::factorial( 3 ) == 6 );
    CHECK( utl::factorial( 10 ) == 3628800 );
}


TEST_CASE( "testing shape class" ) {
    Object shape;
    shape.setSurface( 5, 4 );
    CHECK( shape.getSurface() == 20 );
}

TEST_CASE( "testing shape class" ) {
    Object shape;
    shape.setVolume( 2, 3, 4 );
    CHECK( shape.getVolume() == 24 );
}
