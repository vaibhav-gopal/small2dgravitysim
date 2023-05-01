class Field {
  PVector[][] vectorField;
  float scl;
  float w, h;
  int cols, rows;
  float gravConstant = 0.5;

  Field(float scl_, float w_, float h_) {
    scl = scl_;
    w = w_;
    h = h_;
    cols = floor(w / scl);
    rows = floor(h / scl);

    vectorField = new PVector[cols][rows];
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        vectorField[x][y] = new PVector(0, 0);
      }
    }
  }

  void drawVector(float x_, float y_, PVector vect) {
    pushMatrix();
    stroke(0);
    noFill();
    translate(x_ * scl + scl/2, y_ * scl + scl/2);
    rotate(vect.heading());
    line(0, 0, vect.mag() * 150, 0);
    popMatrix();
  }

  void calculateField(Body b) {
    for (int x = 0; x < cols; x++) {
      for (int y = 0; y < rows; y++) {
        PVector diff = PVector.sub(b.pos, new PVector(x * scl + scl/2, y * scl + scl/2));
        if (diff.mag() > b.r) {
          //equation below, again idk if this is accurate
          //produces a gravitation accleration at a specific point
          diff.setMag((gravConstant * b.mass) / pow(diff.mag(), 2));
          vectorField[x][y] = diff.copy();
        }
        drawVector(x, y, vectorField[x][y]);
      }
    }
  }
}
