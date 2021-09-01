GOL gol;

boolean drawing = false;

void setup(){
  size(720, 480);
  gol = new GOL(8);
}

void draw(){
  if(!drawing){
  gol.nextGen();
  }
  gol.display();
}

void mousePressed(){
  gol.init();
}

void keyPressed(){
  drawing = !drawing;
}
