// - - - - - - - - - - - - - - - - - - - - - - - 
// tron04 internet-controlled snake
// Scott Sullivan
// - - - - - - - - - - - - - - - - - - - - - - -

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
  noStroke();
}

void draw() {
  frame.setTitle("Spark Core 2D Cycle / " + int(frameRate) + " fps");
  
  background(255);
  fill(#000000);

  getData();

  for (int i = 0; i <= 20; i++) {

  rect(snakePos.x, snakePos.y, 1, 1);
  cords.add(new Cord(snakePos.x, snakePos.y));

  display();
  turn();
  eval();
  }
}

//pull the data from the spark cloud
void getData(){
  jsOneLR = loadJSONObject("https://api.spark.io/v1/devices/{DEVICE_ID}/oneLR?access_token={ACCESS_TOKEN}");
  jsOneUD = loadJSONObject("https://api.spark.io/v1/devices/{DEVICE_ID}/oneUD?access_token={ACCESS_TOKEN}");

  oneLR = jsOneLR.getInt("result");
  oneUD = jsOneUD.getInt("result");
}

// evaluate a crash
void eval() {
  for (int i = cords.size()-1; i >= 0; i--) {
    Cord cord = cords.get(i);
    if ((snakePos.x == cord.x) && (snakePos.y == cord.y)) {
      state = 5;
    }
  }
}

//display the wall
void display() {
  for (int i = cords.size()-1; i >= 0; i--) {
    Cord cord = cords.get(i);
    rect(cord.x, cord.y, 2, 2);
  }
}

//evaluate and make turns
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
}

// array list
class Cord {
  float x;
  float y;
  
  Cord(float x_, float y_) {
    x = x_;
    y = y_;
  }
}

