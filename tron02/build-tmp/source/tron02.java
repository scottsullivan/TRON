import processing.core.*; 
import processing.data.*; 
import processing.event.*; 
import processing.opengl.*; 

import java.util.HashMap; 
import java.util.ArrayList; 
import java.io.File; 
import java.io.BufferedReader; 
import java.io.PrintWriter; 
import java.io.InputStream; 
import java.io.OutputStream; 
import java.io.IOException; 

public class tron02 extends PApplet {

PVector snakePos;
int state = 1;
ArrayList<Cord> cords;

public void setup() {
  size(1000, 500, P3D);
  background(0xffffffff);
  snakePos = new PVector(width/2, height -1);
  cords = new ArrayList<Cord>();
}

public void draw() {
  background(0xffffffff);
  noFill();
  stroke(255);

  fill(0xff000000);
  noStroke();

  rect(snakePos.x, snakePos.y, 1, 1);
  cords.add(new Cord(snakePos.x, snakePos.y));

  if (state == 1) {
    snakePos.y--;
    snakePos.x = snakePos.x;
  }
  if (state == 2) {
    snakePos.x++;
    snakePos.y = snakePos.y;
  }
  if (state == 3) {
    snakePos.y++;
    snakePos.x = snakePos.x;
  }
  if (state == 4) {
    snakePos.x--;
    snakePos.y = snakePos.y;
  }
  if (state == 5) {
    snakePos.x = snakePos.x;
    snakePos.y = snakePos.y;
    fill(0xffFF0000);
    //text("CRASH!!!", snakePos.x + 5, snakePos.y - 5);
  }

  eval();
  display();
}

public void eval() {
  for (int i = cords.size()-1; i >= 0; i--) {
    Cord cord = cords.get(i);
    if ((snakePos.x == cord.x) && (snakePos.y == cord.y)) {
      state = 5;
    }
  }
}

public void display() {
  for (int i = cords.size()-1; i >= 0; i--) {
    Cord cord = cords.get(i);
    rect(cord.x, cord.y, 2, 2);
  }
}

public void keyPressed() {
  if (key == CODED) {
    if (keyCode == UP) {
      state = 1;
    }
    if (keyCode == RIGHT) {
      state = 2;
    }
    if (keyCode == DOWN) {
      state = 3;
    }
    if (keyCode == LEFT) {
      state = 4;
    }
  }
}

class Cord {
  float x;
  float y;
  
  Cord(float x_, float y_) {
    x = x_;
    y = y_;
  }
}
  static public void main(String[] passedArgs) {
    String[] appletArgs = new String[] { "tron02" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
