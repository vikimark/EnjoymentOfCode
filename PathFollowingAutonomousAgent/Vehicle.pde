class Vehicle {
  PVector loc;
  PVector velo;
  PVector acc;
  PVector predictLoc;

  float maxSpeed;
  float maxForce;

  float r;
  float rTarget = 0;

  Vehicle(float x, float y) {
    loc = new PVector(x, y);
    velo = new PVector(random(5), random(-5, 5));
    acc = new PVector(0, 0);
    predictLoc = new PVector(x, y);

    maxSpeed = 3;
    maxForce = 0.2;

    r = 5;
  }

  void update() {
    velo.add(acc);

    velo.limit(maxSpeed);
    loc.add(velo);

    PVector predictVelo = velo.copy();
    predictLoc = loc.copy();
    predictVelo.mult(25);
    predictLoc.add(predictVelo);

    acc.mult(0);
  }

  void applyForce(PVector force) {
    acc.add(force);
  }

  void display() {
    float theta = velo.heading() - PI/2;


    pushMatrix();
    fill(200, 127, 0);
    noStroke();
    translate(loc.x, loc.y);
    rotate(theta);
    beginShape();
    vertex(0, r);
    vertex(-r, -r*2);
    vertex(r, -r*2);
    endShape(CLOSE);
    fill(154, 0, 0);
    popMatrix();
    //ellipse(predictLoc.x, predictLoc.y, 12, 12);
  }

  void seek(PVector target) {
    PVector desired = PVector.sub(target, loc);



    //float dist = target.dist(loc);
    //if (dist <= rTarget) {
    //  float speed = map(dist, 0, rTarget, 0, maxSpeed);
    //  desired.setMag(speed);
    //} else
    desired.setMag(maxSpeed);

    PVector steering = PVector.sub(desired, velo);
    steering.limit(maxForce); // Limit to maximum steering


    this.applyForce(steering);
  }

  void borderCheck() {
    if (loc.x >= width) {
      loc.x = 0 + r;
    }
    if (loc.x <= 0) {
      loc.x = width - r;
    }
    if (loc.y >= height) {
      loc.y = 0 + r;
    }
    if (loc.y <= 0) {
      loc.y = height - r;
    }
  }

  void follow(Path p) {
    PVector normal;
    PVector target = null;
    float worldRec = 100000000;

    for (int i = 0; i < p.points.size(); i++) {
      PVector a = p.points.get(i);
      PVector b = p.points.get((i+1)%p.points.size()); // Path has to wrap around
      normal = getNormalPoint(predictLoc, a, b);
      
      PVector dir = PVector.sub(b, a);
      if (normal.x < min(a.x, b.x) || normal.x > max(a.x, b.x)){
        normal = b.get();
        
        a = p.points.get((i+1)%p.points.size());
        b = p.points.get((i+2)%p.points.size());  // Path wraps around
        dir = PVector.sub(b, a);
      }

      float dist = PVector.sub(normal, predictLoc).mag();
      if (dist < worldRec)
      {
        worldRec = dist;
        target = normal;

        PVector add;
        add = dir.get();
        add.normalize();
        add.mult(25);
        target.add(add);
      }
    }
    if (worldRec > p.r) {
      //fill(50, 0, 0);
      //ellipse(target.x, target.y, 20, 20);

      seek(target);
    } else {
      //fill(255, 0, 0);
      //ellipse(target.x, target.y, 20, 20);
    }
    //stroke(0, 100);
    //line(predictLoc.x, predictLoc.y, target.x, target.y);
  }

  PVector getNormalPoint(PVector p, PVector a, PVector b) {
    PVector pa = PVector.sub(p, a);
    PVector ba = PVector.sub(b, a);

    ba.normalize();
    ba.mult(ba.dot(pa));

    ba.add(a); // translate ba to where point a is

    return ba;
  }
  
  void seperate(ArrayList<Vehicle> vehilcles) {
    float desiredSep = 40;

    PVector sum = new PVector();
    int count = 0;
    for (Vehicle other : vehilcles) {
      float d = PVector.sub(loc, other.loc).mag();

      if (d > 0 && d < desiredSep) {
        PVector diff = PVector.sub(loc, other.loc);
        diff.normalize(); // why normalizing?
        diff.div(d);
        sum.add(diff);
        count++;
      }
    }
    if (count > 0) {
      sum.div(count);
      
      sum.setMag(maxSpeed);
      
      PVector steer = PVector.sub(sum, velo);
      steer.limit(maxForce);
      
      applyForce(steer);
    }

    
  }
}
