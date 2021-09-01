/*
1) The Box2D World
 - "main" tab
 - setup()
 2) Create a Body
 - "Box" constructor
 3) Ask Box2d Where is the Body? --> do in Box.Display();  
 */


/* 
 To connected with box2D we need to create a reference called "Body"
 !To create body! 
 1) create a Body def
 - Position 
 - Type
   - Dynamic 
   - static
   - kinetic for user control
 2) Create the body
 3) Create a Shape Ex. PolygonShape, circle, Chianshape
 4) Create a Fixture (set some physics parameters)
 - Density
 - friction
 - restitution ??(what is it?) -> elasticity or bounciness  
 5) Put it all together!    
 */


class Boxes {
  PVector loc;
  PVector velo;
  PVector acc;

  Body body;



  Boxes(float x, float y) {
    loc = new PVector(x, y);
    velo = new PVector(0, 0);
    acc = new PVector(0, 0);

    // Step 1: Define Body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y)); // Convert Pixels coor to world's coordinate

    // Step 2: Create Body
    body = box2d.createBody(bd);

    // Step 3: Create Shape
    PolygonShape ps = new PolygonShape();
    float box2Dw = box2d.scalarPixelsToWorld(10/2); // devieded by 2 because in box2d width and heigth start counting from center to an end
    float box2Dh = box2d.scalarPixelsToWorld(10/2);
    ps.setAsBox(box2Dw, box2Dh);

    // Step 4: Create Fixture
    FixtureDef fd = new FixtureDef();
    fd.shape = ps; // Key line of code
    // Parameters that affect physics
    fd.density = 1;
    fd.friction = 0.3;
    fd.restitution = 0.8;

    // Step 5: Attach Shape to Body with Fixture
    body.createFixture(fd);
  }

  void update() {
  }

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float angle = body.getAngle();

    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-angle); // Processing window y axis point downward so angle too -> flip angle
    fill(174);
    rectMode(CENTER);
    rect(0, 0, 10, 10);
    popMatrix();
  }

  Vec2 getVec2() {
      Vec2 pos = box2d.getBodyPixelCoord(body);
      
      return pos; 
  }
  
  void kill(){
    box2d.destroyBody(body);
  }
}
