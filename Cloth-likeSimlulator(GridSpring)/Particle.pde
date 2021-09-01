class Particle extends VerletParticle2D{
  
  Particle(Vec2D loc){
    super(loc);
    
    
  }
  
  void display(){
    fill(127);
    stroke(0);
    strokeWeight(1);
    //ellipse(x, y, 4, 4);
  }
}
