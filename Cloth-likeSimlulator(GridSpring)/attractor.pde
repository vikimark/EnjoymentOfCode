class Attractor extends VerletParticle2D{
  
  float r = 4;
  Attractor(Vec2D loc){
    super(loc);
    
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior2D(this, r*16, -20));
  }
  
  
}
