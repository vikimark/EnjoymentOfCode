import toxi.physics2d.*;
import toxi.physics2d.behaviors.*;
import toxi.geom.*;

VerletPhysics2D physics;
Grid g;
Attractor a;

void setup(){
  size(680, 760);
  physics = new VerletPhysics2D();
  physics.addBehavior(new GravityBehavior2D(new Vec2D(0, 0.5)));
  
  physics.setWorldBounds(new Rect(0, 0, width, height));
  
  g = new Grid();
  a = new Attractor(new Vec2D(3 * width/4, 3 * height/4));
  smooth();
}

void draw(){
  background(255);
  physics.update();
  g.display();
  
  if(mousePressed){
    
    a.lock();
    a.x = mouseX;
    a.y = mouseY;
    a.unlock();
  }
}
