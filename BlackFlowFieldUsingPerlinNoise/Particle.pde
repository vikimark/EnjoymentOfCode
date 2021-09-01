class Particle{
  PVector pLoc;
  PVector loc;
  PVector velo;
  PVector acc;
  
  float maxSpeed = 5;
  
  boolean skip = false;
  
  Particle(){
    loc = new PVector(random(width), random(height));
    pLoc = loc.copy();
    velo = new PVector(0, 0);
    acc = new PVector(0, 0);
  }
  
  void update(){
    pLoc = loc.copy();
    velo.add(acc);
    velo.limit(maxSpeed);
    loc.add(velo);
    
    acc.mult(0);
  }
  
  void applyForce(PVector force){
    acc.add(force);
  }
  
  void flowfield(FlowField ff){
    int xScl = constrain(int(loc.x/ff.scl), 0, ff.cols - 1);
    int yScl = constrain(int(loc.y/ff.scl), 0, ff.rows - 1);
    int index = xScl + yScl * ff.cols;
    applyForce(ff.flowfield[index].setMag(5));
  }
  
  void display(){
    stroke(0, 6);
    //point(loc.x, loc.y);
    if(!skip){
      line(pLoc.x, pLoc.y, loc.x, loc.y);
    }
    skip = false;
  }
  
  void edge(){
    if(loc.x > width){loc.x = 0; skip = true;}
    if(loc.x < 0){loc.x = width; skip = true;}
    if(loc.y > height){loc.y = 0; skip = true;}
    if(loc.y < 0){loc.y = height; skip = true;}
  }
}
