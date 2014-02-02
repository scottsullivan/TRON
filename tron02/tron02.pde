PVector snakePos;
int state = 1;
ArrayList<Cord> cords;

void setup() {
  size(1000, 500, P3D);
  background(#ffffff);
  snakePos = new PVector(width/2, height -1);
  cords = new ArrayList<Cord>();
}

void draw() {
  background(#ffffff);
  noFill();
  stroke(255);

  fill(#000000);
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
    fill(#FF0000);
    //text("CRASH!!!", snakePos.x + 5, snakePos.y - 5);
  }

  eval();
  display();
}

void eval() {
  for (int i = cords.size()-1; i >= 0; i--) {
    Cord cord = cords.get(i);
    if ((snakePos.x == cord.x) && (snakePos.y == cord.y)) {
      state = 5;
    }
  }
}

void display() {
  for (int i = cords.size()-1; i >= 0; i--) {
    Cord cord = cords.get(i);
    rect(cord.x, cord.y, 2, 2);
  }
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

