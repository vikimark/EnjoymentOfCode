class DNA{
  PVector[] force;
  float fitness;
  float prob;
  int frame;
  
  DNA(int frame_){
    frame = frame_;
    force = new PVector[frame];
    initVelo(force);
    
    fitness = 0;
    prob = 0;
    
  }
  
  float calFitness(PVector target, PVector loc){
    float d = dist(loc.x, loc.y, target.x, target.y);
    
    fitness = 1/ d*d;
    return fitness;
  }
  
  void initVelo(PVector[] force){
    for(int i = 0; i < force.length; i++){
      force[i] = PVector.random2D();
    }
  }
  
  Rocket crossover(DNA b, float mutationRate){
    int middle = floor(random(force.length));
    DNA child = new DNA(frame);
    for(int i = 0; i < force.length; i++){
      if(i < middle){
        child.force[i] = force[i];
      }else child.force[i] = b.force[i];
    }
    mutation(child, mutationRate);
    Rocket chi = new Rocket(child, frame);
    return chi;
  }
  
  void mutation(DNA child, float mutationRate){
    float r;
    for(int i = 0; i < child.force.length; i++){
      r = random(1);
      if(r < mutationRate){
        child.force[i] = PVector.random2D();
      }
    }
  }
}
