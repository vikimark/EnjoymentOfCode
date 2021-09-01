class Wave {
  float angle;
  float[] yValues;
  float spacing;
  float aV;
  float amp;
  float period;
  float dy;
  color c;

  Wave(float a_, float spacing_, float period_, float amp_, color c_) {
    angle = a_;
    spacing = spacing_;
    period = period_;
    amp = amp_;
    yValues = new float[(int)(width/spacing)];
    dy = (TWO_PI/ period) * spacing;
    aV = 0.02;
    c = c_;
    
    
  }

  void update(){
    float theta = angle;
    for (int i = 0; i<yValues.length; i++) {
      yValues[i] = amp * sin(theta);
      theta += dy;
    }
    angle += aV;
  }
  
  void render(){
    fill(c);
    noStroke();
    pushMatrix();
    ellipseMode(CENTER);
    translate(0, height/2);
    for(int i = 0; i<yValues.length; i++){
      ellipse(i * spacing, yValues[i], 12, 12);
    }
    popMatrix();
  }
  
  void addWave(Wave m){
    for(int i=0; i<yValues.length; i++){
      yValues[i] += m.yValues[i];
    }
  }
}
