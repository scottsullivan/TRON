float size = 1000;

PVector snakePos;
int state = 1;
ArrayList<Cord> cords;

void setup() {
  size(1280, 720, P3D);
  rectMode(CENTER);
  frameRate(60);

  snakePos = new PVector(0, size/2);
  cords = new ArrayList<Cord>();

  noStroke();
  smooth();
}

void draw() {
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
    fill(#FF0000);
  }



  ground();

  fill(255);
}

void cameraAndLights() {
  camera(-255, height, (height/2.0) / tan(PI*30.0 / 180.0), 0, 0, -100, 0, 0, -1);
  directionalLight(255, 0, 0, 1, 0, 1);
  directionalLight(255, 0, 0, -1, 0, -1);
  directionalLight(0, 0, 255, 0, -1, 0);
  ambientLight(120, 120, 120);
  lightSpecular(51, 102, 126);
}

void walls() {
  //back wall
  beginShape();
  vertex(-size*.75, -size/2, 500);
  vertex(-size*.75, -size/2, 0);
  vertex(size*.75, -size/2, 0);
  vertex(size*.75, -size/2, 500);
  endShape(CLOSE);

  //right wall
  beginShape();
  vertex(size*.75, -size/2, 500);
  vertex(size*.75, -size/2, 0);
  vertex(size*.75, size/2, 0);
  vertex(size*.75, size/2, 500);
  endShape(CLOSE);

  //left wall
  beginShape();
  vertex(-size*.75, -size/2, 500);
  vertex(-size*.75, -size/2, 0);
  vertex(-size*.75, size/2, 0);
  vertex(-size*.75, size/2, 500);
  endShape(CLOSE);

  //  beginShape();
  //  vertex(-size/2, 0, 30);
  //  vertex(-size/2, 0, 0);
  //  vertex(size/2, 0, 0);
  //  vertex(size/2, 0, 30);
  //  endShape(CLOSE);
}

void ground() {
  //floor
  fill(150);
  rect(0, 0, size*1.5, size);

  stroke(255);
  for (int i = 50; i < size; i = i+50) {
    line(-size*.75, i-size/2, size*.75, i-size/2);
  }
  for (int i = 50; i < size*1.5; i = i+50) {
    line(i-size*.75, -size/2, i-size*.75, size/2);
  }
  noStroke();
}

void eval() {
  for (int i = cords.size()-1; i >= 0; i--) {
    Cord cord = cords.get(i);
    if ((snakePos.x == cord.x) && (snakePos.y == cord.y)) {
      state = 5;
      println("CRASH");
    }
  }
}

void display() {
  beginShape();
  for (int i = cords.size()-1; i >= 0; i--) {
    Cord cord = cords.get(i);

    vertex(cord.x, cord.y, 30);
    vertex(cord.x, cord.y, 0);
  }
  endShape();
}




void keyPressed() {
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

