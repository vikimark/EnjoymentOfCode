CA ca;

void setup(){
  size(700, 380);
  ca = new CA(10);
  background(50);
}

void draw(){
  ca.display();
  ca.nextGen();
  ca.ruleCheck();
  
  fill(0, 0, 175);
  text("rule : " + ca.rules, 0, 10);
  //println(ca.rowsCount, ca.rows, ca.rules);
  //for(int i = 0; i < ca.ruleset.length; i++){
  //  print(ca.ruleset[i] + " ");
  //}
}

//void mousePressed(){
//  ca.ruleCheck();
//}
