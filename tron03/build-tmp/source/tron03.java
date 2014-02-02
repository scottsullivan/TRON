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

public class tron03 extends PApplet {

float size = 1000;

PVector snakePos;
int state = 1;
ArrayList<Cord> cords;

public void setup() {
  size(1280, 720, P3D);
  rectMode(CENTER);
  frameRate(60);

  snakePos = new PVector(0, size/2);
  cords = new ArrayList<Cord>();

  noStroke();
  smooth();
}

public void draw() {
  background(0);

  cameraAndLights();
  walls();
  eval();

  noFill();
  stroke(255);
  display();

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
  }



  ground();

  fill(255);
}

public void cameraAndLights() {
  camera(-255, height, (height/2.0f) / tan(PI*30.0f / 180.0f), 0, 0, -100, 0, 0, -1);
  directionalLight(255, 0, 0, 1, 0, 1);
  directionalLight(255, 0, 0, -1, 0, -1);
  directionalLight(0, 0, 255, 0, -1, 0);
  ambientLight(120, 120, 120);
  lightSpecular(51, 102, 126);
}

public void walls() {
  //back wall
  beginShape();
  vertex(-size*.75f, -size/2, 500);
  vertex(-size*.75f, -size/2, 0);
  vertex(size*.75f, -size/2, 0);
  vertex(size*.75f, -size/2, 500);
  endShape(CLOSE);

  //right wall
  beginShape();
  vertex(size*.75f, -size/2, 500);
  vertex(size*.75f, -size/2, 0);
  vertex(size*.75f, size/2, 0);
  vertex(size*.75f, size/2, 500);
  endShape(CLOSE);

  //left wall
  beginShape();
  vertex(-size*.75f, -size/2, 500);
  vertex(-size*.75f, -size/2, 0);
  vertex(-size*.75f, size/2, 0);
  vertex(-size*.75f, size/2, 500);
  endShape(CLOSE);

  //  beginShape();
  //  vertex(-size/2, 0, 30);
  //  vertex(-size/2, 0, 0);
  //  vertex(size/2, 0, 0);
  //  vertex(size/2, 0, 30);
  //  endShape(CLOSE);
}

public void ground() {
  //floor
  fill(150);
  rect(0, 0, size*1.5f, size);

  stroke(255);
  for (int i = 50; i < size; i = i+50) {
    line(-size*.75f, i-size/2, size*.75f, i-size/2);
  }
  for (int i = 50; i < size*1.5f; i = i+50) {
    line(i-size*.75f, -size/2, i-size*.75f, size/2);
  }
  noStroke();
}

public void eval() {
  for (int i = cords.size()-1; i >= 0; i--) {
    Cord cord = cords.get(i);
    if ((snakePos.x == cord.x) && (snakePos.y == cord.y)) {
      state = 5;
      println("CRASH");
    }
  }
}

public void display() {
  beginShape();
  for (int i = cords.size()-1; i >= 0; i--) {
    Cord cord = cords.get(i);

    vertex(cord.x, cord.y, 30);
    vertex(cord.x, cord.y, 0);
  }
  endShape();
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
    String[] appletArgs = new String[] { "tron03" };
    if (passedArgs != null) {
      PApplet.main(concat(appletArgs, passedArgs));
    } else {
      PApplet.main(appletArgs);
    }
  }
}
