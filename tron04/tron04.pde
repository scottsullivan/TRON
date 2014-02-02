PVector snakePos;
int state = 1;
int mover = 1366;
ArrayList<Cord> cords;
boolean centered = true;
JSONObject jsOneUD, jsOneLR;
int oneLR, oneUD;

void setup() {
  size(1000, 500, P3D);
  background(#ffffff);
  snakePos = new PVector(width/2, height -1);
  cords = new ArrayList<Cord>();
}

void draw() {
  frame.setTitle("Spark Core 2D Cycle / " + int(frameRate) + " fps");
  background(255);

  jsOneLR = loadJSONObject("https://api.spark.io/v1/devices/53ff6e065067544851291287/oneLR?access_token=f03238d90e391bb4c381d8bed162d272db1f2840");
  jsOneUD = loadJSONObject("https://api.spark.io/v1/devices/53ff6e065067544851291287/oneUD?access_token=f03238d90e391bb4c381d8bed162d272db1f2840");

  oneLR = jsOneLR.getInt("result");
  oneUD = jsOneUD.getInt("result");

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
  }

  turn();
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

void turn() {
  if (centered = true) {
    if (oneUD > mover*2) {
      state = 1;
      centered = false;
    }
    if (oneUD < mover) {
      state = 3;
      centered = false;
    }
    if (oneLR > mover*2) {
      state = 2;
      centered = false;
    }
    if (oneLR < mover) {
      state = 4;
      centered = false;
    }
  }else{
    if((oneUD < mover*2) && (oneUD > mover) && (oneLR < mover*2) & (oneLR > mover)) {
      centered = true;
    }
  }
}

