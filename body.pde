class Body {
  PVector pos;
  PVector vel = new PVector(0, 0);
  PVector accel = new PVector(0, 0);
  float mass;
  float d, r;
  float maxSpeed = 5;

  Body(float x, float y, float mass_, float d_) {
    pos = new PVector(x, y);
    mass = mass_;
    d = d_;
    r = d/2;
  }

  void update() {
    
    
    vel.add(accel).limit(maxSpeed);
    pos.add(vel);
    accel.mult(0);

    edges();
    show();
  }

  void show() {
    stroke(0);
    noFill();
    ellipse(pos.x, pos.y, d, d);
  }

  void edges() {
    if (pos.x > width + r) {
      pos.x = 0 - r;
    }
    if (pos.x < 0 - r) {
      pos.x = width + r;
    }
    if (pos.y > height + r) {
      pos.y = 0 - r;
    }
    if (pos.y < 0 - r) {
      pos.y = height + r;
    }
  }

  void applyForce(PVector force) {
    accel.add(force.div(mass));
  }

  void applyAccel(PVector accel_) {
    accel.add(accel_);
  }
  
  void applyField(Field vectors){
    int x = constrain(floor(pos.x / forceMap.scl), 0, vectors.cols - 1);
    int y = constrain(floor(pos.y / forceMap.scl), 0, vectors.rows - 1);
    
    //idk if this is accurate, im just applying the acceleration to the object
    //regardless of its mass
    accel.add(vectors.vectorField[x][y]);
  }
}
