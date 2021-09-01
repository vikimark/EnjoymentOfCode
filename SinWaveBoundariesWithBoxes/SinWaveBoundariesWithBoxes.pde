

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

ArrayList<Boxes> b;
ArrayList<Surface> boun;
boolean on;

Box2DProcessing box2d;

void setup() {
  size(640, 480);
  b = new ArrayList<Boxes>();
  boun = new ArrayList<Surface>();

  box2d = new Box2DProcessing(this); //main object
  box2d.createWorld();

  boun.add(new Surface(width/2, height/2, 200, 4, 120)); // x, y, period, space, amp
  
  on = true;
  smooth();
}

void draw() {
  background(250);

  box2d.step();

  if (mousePressed) {
    b.add(new Boxes(mouseX, mouseY));
  }

  for (int i = b.size()-1; i>=0; i--) {

    Boxes c = b.get(i);
    c.display();

    Vec2 pos;
    pos = c.getVec2();
    if (pos.y > height) {
      b.remove(i);
    }
  }

  for (Surface j : boun) {
    j.changeShape();
    j.display();
  }
  println(b.size());
  
  Surface a = boun.get(0);
  
  if (on) {
    a.aV = 0.075;
  }else {
    a.aV = 0;
  }
}

void keyPressed() {
  
  //for (int i = b.size() - 1; i >= 0; i--)
  //{
  //  Boxes j = b.get(i);
  //  j.kill();
  //}
  //b.clear();
  
  on = !on;
  
  
}
