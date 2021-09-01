
import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;
Node n;
ArrayList<VerletSpring2D> s;

void setup() {
  size(680, 480);
  physics = new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.5)));

  physics.setWorldBounds(new Rect(0, 0, width, height));

  n = new Node(new Vec2D(width/2, 50), floor(random(100)));
  s = new ArrayList<VerletSpring2D>();
  
  for(int i = 0; i < 10; i++){
    n.addNode(floor(random(100)));
  }
  n.visit();
  n.toPhy();
  
  n.lock();
  smooth();
  
  // Done -- reminded to add node into physics world

//  for (int i = 0; i < p.size()-1; i++){
//      Node p1 = p.get(i);
//      Node p2 = p.get(i+1);
//      s.add(new VerletSpring2D(p1, p2, 5, 0.5));
//    }

//  for (Node a : p) {
//    physics.addParticle(a);
//  }

//  for (VerletSpring2D a : s) {
//    physics.addSpring(a);
//  }
  
//  Node a = p.get(0);
//  a.lock();
//  a = p.get(p.size() - 1);
//  a.lock();
//  smooth();

}

void draw() {
  background(255);
  physics.update();
  
  n.display();

  //for (Node a : p) {
  //  a.display();
  //}
  //stroke(0);
  //strokeWeight(5);
  //for (int i = 0; i < p.size() - 1; i++){
  //    Node p1 = p.get(i);
  //    Node p2 = p.get(i+1);
  //    line(p1.x, p1.y, p2.x, p2.y);
  //  }
    
//  if(mousePressed){
//    Node a = p.get((p.size() - 1)/2);
//    a.lock();
//    a.x = mouseX;
//    a.y = mouseY;
//    a.unlock();
//  }
}
