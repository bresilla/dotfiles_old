#pragma once
#include <iostream>
// #include "fmt/format.h"

class Object {
public:
    ///width of the object
    int width;
    /// heigh of the object
    int heigh;
    /// depth of the object
    int depth;

private:
    int surface;
    int volume;

public:
    void setSurface( int a, int b );
    void setVolume( int a, int b, int c );
    int getSurface();
    int getVolume();
};
