class FlowField{
  int scl;
  int cols;
  int rows;
  PVector flowfield[];
  float inc = 0.02;
  
  float zoff;
  
  FlowField(int scl_){
    scl = scl_;
    cols = width/scl;
    rows = height/scl;
    flowfield = new PVector[cols * rows];
    zoff = 0;
    
    this.init();
  }
  
  void init(){
    float xoff = 0; 
    float yoff = 0;
    for(int y = 0; y < rows; y++){
      xoff = 0;
      for(int x = 0; x < cols; x++){
        int index = x + y * cols;
        float angle = noise(xoff, yoff, zoff) * TWO_PI * 2;
        flowfield[index] = PVector.fromAngle(angle);
        xoff += inc;
      }
      yoff += inc;
    }
    zoff += 0.001;
  }
  
  void display(){
      for(int y = 0; y < rows; y++){
        for(int x = 0; x < cols; x++){
          int index = x + y * cols;
          float angle = flowfield[index].heading();
          
          float xcoord = x * scl;
          float ycoord = y * scl;
          pushMatrix();
          translate(xcoord, ycoord);
          rotate(angle);
          fill(255);
          stroke(255);
          strokeWeight(1);
          line(0, 0, scl, 0);
          popMatrix();
        }
      }
  }
}
