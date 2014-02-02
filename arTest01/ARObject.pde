// class that defines the AROBject, both the AR detection and display are handled inside this class
class ARObject {
  int ID; // keep track of the current the ID of the object (corresponds with the ID i of the marker)
  PVector rot, speed; // in this example the cube has a certain rotation and rotates at a certain speed

    ARObject(int ID) {
    this.ID = ID; // set the ID
  }

  void run() {
    // always keep rotating (even when the marker is NOT detected)
    //rot.add(speed);
    // checks the object's corresponding marker through the ID
    // if the marker is found, display the cube
    if (nya.isExistMarker(ID)) { 
      display();
    }
  }

  // the display in this example shows a colored, rotating RGBCube
  void display () {

    int UD = arduino.analogRead(0);
    int LR = arduino.analogRead(1);

    float UDscaled = map(UD, 0, 1024, -TWO_PI/3, TWO_PI/3);
    float LRscaled = map(LR, 0, 1024, -TWO_PI/3, TWO_PI/3);

    println(UD);



    rot = new PVector(UDscaled, LRscaled, 0); // random x, y, z rotation
    //speed = new PVector(random(-mS, mS), random(-mS, mS), random(-mS, mS)); // random x, y, z speed (within maxSpeed boundaries)

    // get the Matrix for this marker and use it (through setMatrix)
    setMatrix(nya.getMarkerMatrix(ID));
    scale(1, -1); // turn things upside down to work intuitively for Processing users

    // hover the cube a little above the real-world marker image
    translate(0, 0, 30);

    // rotate the cube in 3 dimensions
    rotateX(rot.x);
    rotateY(rot.y);
    rotateZ(rot.z);
    // scale - as with the the color range - to save typing with the coordinates (and make it much easier to change the size)
    scale(25);

    // a cube made out of 6 quads
    // the 1 range can be used for both the color and the coordinates as a result of color range and scale (see earlier)
    beginShape(QUADS);
    fill(#0365FF);
    vertex(-1, 1, 1);
    vertex( 1, 1, 1);
    vertex( 1, -1, 1);
    vertex(-1, -1, 1);

    fill(#16FF03);
    vertex( 1, 1, 1);
    vertex( 1, 1, -1);
    vertex( 1, -1, -1);
    vertex( 1, -1, 1);

    fill(#FFF700);
    vertex( 1, 1, -1);
    vertex(-1, 1, -1);
    vertex(-1, -1, -1);
    vertex( 1, -1, -1);

    fill(#E000FF);
    vertex(-1, 1, -1);
    vertex(-1, 1, 1);
    vertex(-1, -1, 1);
    vertex(-1, -1, -1);

    fill(#A5FF00);
    vertex(-1, 1, -1);
    vertex( 1, 1, -1);
    vertex( 1, 1, 1);
    vertex(-1, 1, 1);

    fill(#FF1A05);
    vertex(-1, -1, -1);
    vertex( 1, -1, -1);
    vertex( 1, -1, 1);
    vertex(-1, -1, 1);

    endShape();
  }
}

