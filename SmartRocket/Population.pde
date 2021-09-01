class Population{
   Rocket[] rk;
   
   float mutationRate;
   int popNum;
   int lifeSpan;
   int lifeCount;
   
   PVector target;
   PVector obj;
   float objW;
   float objH;
   
   int gen;
   
   Population(float x, float y, int popNum_, int lifeSpan_, float mutationR){
     gen = 0;
     
     popNum = popNum_;
     lifeSpan = lifeSpan_;
     lifeCount = 0;
     mutationRate = mutationR;
     target = new PVector(x, y);
     
     objW = 400;
     objH = 20;
     obj = new PVector(width/2, height/2);
     
     //initialize Rocket
     rk = new Rocket[popNum];
     for(int i = 0; i < rk.length; i++){
       rk[i] = new Rocket(lifeSpan);
     }
   }
   
   void live(){
     for(int i = 0; i < rk.length; i++){
       rk[i].update(lifeCount);
       rk[i].display();
     }
     lifeCount++;
     
   }
   void evaluate(){
     float bestFit = 0;
     for(int i = 0; i < rk.length; i++){
       if(bestFit < rk[i].dna.calFitness(target, rk[i].loc)){
         bestFit = rk[i].dna.fitness;
       }
     }
   }
   
   void selection(){
     float sum = 0;
     for(int i = 0; i < rk.length; i++){
       sum += rk[i].dna.fitness;
     }
     for(int i = 0; i < rk.length; i++){
       rk[i].dna.prob = rk[i].dna.fitness / sum;
     }
   }
   
   Rocket dartingPick(){
     float r = random(1);
     int index = 0;
     
     while(r > 0){
       r -= rk[index].dna.prob;
       if(index < rk.length-1)
       index++;
     }
     if(index != rk.length-1)
     index--;
     
     return rk[index];
   }
   
   void reproduction(){
     Rocket[] child = new Rocket[rk.length];
     
     for(int i = 0; i < rk.length; i++){
       Rocket a = dartingPick();
       Rocket b = dartingPick();
       
       child[i] = a.dna.crossover(b.dna, mutationRate);
     }
     
     rk = child;
     lifeCount = 0;
     gen++;
   }
   
   void run(){
     if(lifeCount < lifeSpan){
       live();
       float d;
       for(int i = 0; i < popNum; i++){
         d = dist(rk[i].loc.x, rk[i].loc.y, target.x, target.y);
         if(d <= 25){
           rk[i].landed = true;
         }
         if(rk[i].loc.x > obj.x - objW/2 && rk[i].loc.x < obj.x + objW/2 && rk[i].loc.y > obj.y - objH/2 && rk[i].loc.y < obj.y + objH/2){
           rk[i].middleCrashed = true;
         }
         if(rk[i].loc.x > width || rk[i].loc.x < 0 || rk[i].loc.y > height || rk[i].loc.y < 0){
           rk[i].crashed = true;
         }
       }
     }else {
       evaluate();
       for(int i = 0; i < popNum; i++){
         if(rk[i].landed){
           rk[i].dna.fitness *= 10;
         if(rk[i].crashed){
           rk[i].dna.fitness /= 10;
         }
         if(rk[i].middleCrashed){
           rk[i].dna.fitness = 0;
         }
         }
       }
       selection();
       reproduction();
     }
     targetDis();
   }
   
   void targetDis(){
     fill(200, 60, 0, 100);
     ellipse(target.x, target.y, 50, 50);
     
     fill(184, 100);
     rectMode(CENTER);
     rect(obj.x, obj.y, objW, objH);
   }
}
