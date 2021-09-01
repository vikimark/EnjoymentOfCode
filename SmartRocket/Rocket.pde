class Rocket{
  PVector loc;
  PVector velo;
  PVector acc;
  
  DNA dna;
  
  int frame;
  
  boolean skipped;
  boolean landed;
  boolean middleCrashed;
  boolean crashed;
  
  Rocket(DNA dna_, int frame_){
    loc = new PVector(width/2, height-20);
    velo = new PVector(0, 0);
    acc = new PVector(0, 0);
    
    frame = frame_;
    dna = dna_;
    
    skipped = landed = crashed = middleCrashed = false; 
  }
  
  Rocket(int frame_){
    loc = new PVector(width/2, height-20);
    velo = new PVector(0, 0);
    acc = new PVector(0, 0);
    
    frame = frame_;
    dna = new DNA(frame);
    
   skipped = landed = crashed = middleCrashed = false;
  }
  
  void update(int frameC){
    if(!crashed && !landed && !middleCrashed){
    acc.add(dna.force[frameC]);
    acc.setMag(0.7);
    velo.add(acc);
    velo.limit(4);
    loc.add(velo);
    
    acc.mult(0);
    }
    
    
  }
  
  void display(){
    fill(255);
    noStroke();
    float angle = velo.heading();
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(angle);
    rectMode(CENTER);
    rect(0, 0, 20, 5);
    popMatrix();
  }
}
