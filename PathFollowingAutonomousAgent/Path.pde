class Path {

  ArrayList<PVector> points;
  float r;

  Path() {
    r = 20;
    points = new ArrayList<PVector>();
  }

  void addPoint(float x, float y) {
    points.add(new PVector(x, y));
  }

  void display() {
    stroke(0);
    noFill();
    strokeWeight(5);
    beginShape();
    for (PVector v : points) {
      vertex(v.x, v.y);
    }
    endShape(LINE);
  }
}
