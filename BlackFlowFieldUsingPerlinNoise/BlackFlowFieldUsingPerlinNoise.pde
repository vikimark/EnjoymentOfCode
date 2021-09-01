FlowField ff;
ArrayList<Particle> pt;

void setup(){
  size(1280, 760);
  ff = new FlowField(5);
  pt = new ArrayList<Particle>();
  
  for(int i = 0; i < 15000; i++){
    pt.add(new Particle());
  }
  background(255);
}

void draw(){
  
  //ff.display();
  for(int j = 0; j< 1; j++){
  for(Particle i : pt){
    i.flowfield(ff);
    i.update();
    i.edge();
    i.display();
  }
  
  ff.init();
  }
}
