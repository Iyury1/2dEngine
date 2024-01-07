#pragma once
#include "graphics.h"

class game
{
private:
  /* data */
  graphics *gfx = nullptr;
public:
  game(/* args */);
  ~game();

  int exec();
};


