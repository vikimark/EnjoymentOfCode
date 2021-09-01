Population pop;

void setup() {
  size(920, 480);
  pop = new Population(width/2, 100, 200, 400, 0.01);
}

void draw() {
  background(50);
  pop.run();
  
  fill(174, 20, 122);
  textSize(20);
  text("life left : ", 10, height-20);
  text(pop.lifeSpan-pop.lifeCount, 80, height-20);
  
  textSize(20);
  text("GEN : " + pop.gen, 10, height-60);
}
