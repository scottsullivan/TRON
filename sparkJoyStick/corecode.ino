int oneLR = 0;
int oneUD = 0;
int twoLR = 0;
int twoUD = 0;

void setup()
{
  Spark.variable("oneLR", &oneLR, INT);
  Spark.variable("oneUD", &oneUD, INT);
  Spark.variable("twoLR", &twoLR, INT);
  Spark.variable("twoUD", &twoUD, INT);
  pinMode(A0, INPUT);
  pinMode(A1, INPUT);
  pinMode(A2, INPUT);
  pinMode(A3, INPUT);
}

void loop()
{
  oneLR = analogRead(A0);
  oneUD = analogRead(A1);
  twoLR = analogRead(A2);
  twoUD = analogRead(A3);
}