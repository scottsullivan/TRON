import processing.serial.*; 
import cc.arduino.*; 

void arduinoSetup() {
  println(Arduino.list());
  arduino = new Arduino(this, Arduino.list()[4], 57600);

  for (int i = 0; i <= 13; i++) 
    arduino.pinMode(i, Arduino.INPUT);
}

void arduinoUpdate() {

}


