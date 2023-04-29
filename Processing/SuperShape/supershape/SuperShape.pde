class SuperShape {
  
    ShapeConfiguration configOne, configTwo;
    float radius;
    int resolution;
    PVector position = new PVector(0, 0, 0);
  
    PVector[][] globe;
  
    public SuperShape(float radius, int resolution) {
        this.radius = radius;
        this.resolution = resolution;
        globe = new PVector[this.resolution + 1][this.resolution + 1];
    }
  
    public SuperShape(float radius, int resolution, PVector position) {
        this.radius = radius;
        this.resolution = resolution;
        globe = new PVector[this.resolution + 1][this.resolution + 1];
        this.position = position;
    }
    
    public void configByNoise(PVector noisePos) {
      float m1 = noise(noisePos.x - 1, noisePos.y) * 30;
      float m2 = noise(noisePos.x + 1, noisePos.y) * 30;
      PVector nA = new PVector(
          noise(noisePos.x - 1, noisePos.y - 1) * 100,
          noise(noisePos.x, noisePos.y - 1) * 100,
          noise(noisePos.x + 1, noisePos.y - 1) * 100
      );
      PVector nB = new PVector(
          noise(noisePos.x + 1, noisePos.y + 1) * 100,
          noise(noisePos.x, noisePos.y + 1) * 100,
          noise(noisePos.x - 1, noisePos.y + 1) * 100
      );
      ShapeConfiguration a = new ShapeConfiguration(nA.x, nA.y, nA.z, m1);
      ShapeConfiguration b = new ShapeConfiguration(nB.x, nB.y, nB.z, m2);
      configuration(a, b);
    }
    
    public void configuration(ShapeConfiguration one, ShapeConfiguration two) {
        this.configOne = one;
        this.configTwo = two;
    }
    
    
    public void calculateGlobe() {
       for (int i = 0; i < resolution+1; i++) {
          float lat = map(i, 0, resolution, -HALF_PI, HALF_PI);
          float r2 = evaluate(lat, configTwo);
          for (int j = 0; j < resolution+1; j++) {
              float lon = map(j, 0, resolution, -PI, PI);
              float r1 = evaluate(lon, configOne);
              float x = radius * r1 * cos(lon) * r2 * cos(lat);
              float y = radius * r1 * sin(lon) * r2 * cos(lat);
              float z = radius * r2 * sin(lat);
              globe[i][j] = new PVector(x + position.x, y + position.y, z + position.z);
          }
        } 
    }
    
    float evaluate(float theta, ShapeConfiguration config) {
        float a = config.a;
        float b = config.b;
        float m = config.m;
        float n1 = config.n1;
        float n2 = config.n2;
        float n3 = config.n3;
        
        float t1 = abs((1/a)*cos(m * theta / 4));
        t1 = pow(t1, n2);
        float t2 = abs((1/b)*sin(m * theta/4));
        t2 = pow(t2, n3);
        float t3 = t1 + t2;
        float r = pow(t3, - 1 / n1);
        return r;
    }
        
    public void draw() {
       noStroke();
       for (int i = 0; i < resolution; i++) {
            float hu = noise(i) * 255;
            fill((hu), 255, 255);
            beginShape(TRIANGLE_STRIP);
            for (int j = 0; j < resolution+1; j++) {
              PVector v1 = globe[i][j];
              vertex(v1.x, v1.y, v1.z);
              PVector v2 = globe[i+1][j];
              vertex(v2.x, v2.y, v2.z);
            }
            endShape();
        }
    }
}
