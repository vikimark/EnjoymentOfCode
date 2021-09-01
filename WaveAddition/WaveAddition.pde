// Create a more complex wave by adding two waves together.

Wave[] w;
int spacing = 2;

void setup() {
  size(1280, 480);
  smooth();
  w = new Wave[3];
  //for(int i = 0; i<w.length; i++){
  //  if(i==0)
  //    w[i] = new Wave(0.0, spacing, 200, 0, color(255)); //blank wave to be the sum
  //else w[i]= new Wave(0.0, spacing, random(100, 600), 60, color(random(255), random(255), random(255))); //set period between 0.2 to 0.3 to set wave to spiral! (don't know why)
  //}
  
  w[0] = new Wave(0.0, spacing, 200, 0, color(254, 221, 190));
  w[1] = new Wave(0.0, spacing, 250, 60, color(24, 90, 219));
  w[2] = new Wave(0.0, spacing, 532, -60, color(255, 201, 71));
}

void draw(){
  background(250);
  stroke(0);
  strokeWeight(5);
  line(0, height/2, width, height/2);
  for(int i = 0; i<w.length; i++)
  {
  w[i].update();
  if(i!= 0){
  w[0].addWave(w[i]);
  w[i].render();
  }
   
  }
  w[0].render();
}

void mousePressed(){
  w[0].aV = 0;
}
