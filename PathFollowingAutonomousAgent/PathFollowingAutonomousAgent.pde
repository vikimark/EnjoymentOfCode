// Silly compare path algorithm

ArrayList<Vehicle> vehi;

boolean debug = true;
Path p;


void setup() {
  size(680, 720);
  smooth();

  vehi = new ArrayList<Vehicle>();
  //vehi.add(new Vehicle(width/2, height/2));
  
  p = new Path();
  //for(int i = 0; i<= 100 ; i++){
  //  p.addPoint( i * width/100, random(height/200) + height/2); 
  //}
  
  p.addPoint(width/4, height/2);
  p.addPoint(width/2, 1* height/4);
  p.addPoint(3*width/4, 3* height/4);
  p.addPoint(width/2, 3 * height/4);
  p.addPoint(width/4, height/2);
}

void draw() {
  if(debug){
  background(255);
  p.display();
  
  for(Vehicle i : vehi){
    i.follow(p);
    i.seperate(vehi);
    i.update();
    i.borderCheck();
    i.display();
  }
  }
}

void keyPressed(){
  debug = !debug;
}

void mousePressed(){
  vehi.add(new Vehicle(mouseX, mouseY));
}
