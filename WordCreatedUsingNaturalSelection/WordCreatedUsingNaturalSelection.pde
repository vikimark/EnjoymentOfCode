Population pop;
PFont f;
String target[];
int index;
int popNum;
float mutationRate;
int fCount;
String best;
void setup() {
  f = createFont("Courier", 32, true);
  size(1000, 480);
  target = new String[4];
  target[0] = "All my bags are packed";
  target[1] = "I'm ready to go";
  target[2] = "I'm standin'here outside your door";
  target[3] = "I hate to wake you up to say goodbye";
  popNum = 1250;
  mutationRate = 0.01;
  index = 0;
  fCount = 0;

  pop = new Population(target[index], popNum, mutationRate);
  index++;
  //pop.printGen();
}

void draw() {
  background(255);
  run();
}

void display() {
  fill(0);
  textFont(f);
  textSize(15);
  text("All phrases: \n" + pop.allPhrase(), 700, 10);

  textSize(25);
  text("Target phrase: \n" + pop.target, 20, 120);

  textSize(25);
  text("Best phrase: \n" + best, 20, 200);

  textSize(15);
  text("Total generation: " + pop.generation, 20, 300);
  text("Average fitness: " + pop.getAvFitness(), 20, 315);
  text("Total population: " + pop.popNum, 20, 330);
  text("Mutation rate: " + int(pop.mutationRate * 100) + "%", 20, 345);
}

void run() {
  //pop.selection();
  pop.dartingPoolSelection();
  best = pop.genetic[pop.indexBest].stringPhrase();
  display();
  println(pop.genetic[pop.indexBest].stringPhrase());



  //pop.reproduction();
  pop.dartingPoolReproduction();
  pop.passDown();

  if (pop.found) {
    if (fCount == 0) {
      fCount = 1;
    } else {
      println(pop.generation);
      println(millis()/1000.0);
      delay(500);
      if (index >= target.length) {
        noLoop();
      } else {
        pop = new Population(target[index], popNum, mutationRate);
        index++;
      }
      fCount = 0;
    }
  }
}
