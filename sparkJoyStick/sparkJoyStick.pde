// - - - - - - - - - - - - - - - - - - - - - - - 
// Spark Core Joy Stick test
// Scott Sullivan
// - - - - - - - - - - - - - - - - - - - - - - -

JSONObject jsOneUD, jsOneLR;

int sizer = 500;

void setup() {
  size(sizer, sizer);
  noFill();
  strokeWeight(2);
}

void draw() {
  frame.setTitle("Spark Core Joy Stick Test 01 / " + int(frameRate) + " fps");

  background(255);
  jsOneLR = loadJSONObject("https://api.spark.io/v1/devices/{DEVICE_ID}/oneLR?access_token={ACCESS_TOKEN}");
  jsOneUD = loadJSONObject("https://api.spark.io/v1/devices/{DEVICE_ID}/oneUD?access_token={ACCESS_TOKEN}");

  int oneLR = jsOneLR.getInt("result");
  int oneUD = jsOneUD.getInt("result");
  
  float xPos = map(oneLR, 0, 4100, 0, width);
  float yPos = map(oneUD, 0, 4100, 0, height);
  
  line(width/2, height/2, xPos, height-yPos);
  ellipse(xPos, height-yPos, 20, 20);
  
  println("lr: " + oneLR);
  println("ud: " + oneUD);
}

