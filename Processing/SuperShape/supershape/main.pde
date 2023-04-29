import peasy.*;

PeasyCam cam;

SuperShape[] shapes;
int quant = 1;
PVector noisePosition;

void setup() {
  size(600, 600, P3D);
  cam = new PeasyCam(this, 500);
  colorMode(HSB);
  
  shapes = new SuperShape[quant];
  
  int dist = 0;
  
  //noisePosition = new PVector(random(0, 1000), random(0, 1000));
  noisePosition = new PVector(0, 0);
  
  for(int i = 0; i < quant; i++) {
      SuperShape shape = new SuperShape(300, 100, new PVector(random(0, dist), random(0, dist), random(0, dist)));
      //ShapeConfiguration a = new ShapeConfiguration(60, 100, 30, 6);
      //ShapeConfiguration b = new ShapeConfiguration(10, 10, 10, 2);
      //shape.configuration(a, b);
      shape.configByNoise(noisePosition);
      shape.calculateGlobe();
      shapes[i] = shape;
  }
  
  
}

float angle = 0;

void draw() {
  background(0);
  lights();
  
  if(angle > 360) {
     noLoop();
     return;
  }
  
  boolean changeConfig = frameCount % 2 == 0;
  for(SuperShape s : shapes) {
     if(changeConfig) {
        s.configByNoise(noisePosition);
        s.calculateGlobe();
     }
     s.draw();
  }
  
  if(changeConfig) {
      angle += .01;
      //noisePosition = new PVector(noisePosition.x + floor(random(-1, 1)), noisePosition.y + floor(random(-1, 1)));
      noisePosition = new PVector(cos(angle), sin(angle));
      println(angle);
  }
  
  //saveFrame("output/super-shape_####.png");
}
