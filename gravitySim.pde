Field forceMap;
ArrayList<Body> bodies = new ArrayList<Body>();

void setup() {
  size(400, 400);
  pixelDensity(1);

  forceMap = new Field(10, width, height);
  for (int i = 0; i < 6; i++){
    bodies.add(new Body(width/2 + random(-180,180), height/2 + random(-180,180), random(50,150), random(40, 80)));
  }
}

void draw() {
  background(255);
  
  for (Body b : bodies) {
    forceMap.calculateField(b);
    b.update();
    b.applyField(forceMap);
  }
}
