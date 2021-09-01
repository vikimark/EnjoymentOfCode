class Surface {
  float x;
  float y;
  float w;
  float h;
  //Wave compo
  float amp;
  float period;
  float dy;
  float spacing;
  
  float angle;
  float aV;

  ArrayList<Vec2> surface;

  Body body;

  Surface(float x_, float y_, float period_, float spacing_, float amp_) {
    
    amp = amp_;
    period = period_;
    spacing = spacing_;
    angle = 0;
    aV = 0.075;
    
    dy = (TWO_PI/ period) * spacing;

    x = x_;
    y = y_;

    surface = new ArrayList<Vec2>();
    changeShape();
   
  }
  
  void makeOb(){
    
     //define chainShape
    ChainShape chain = new ChainShape();
    Vec2[] vertices = new Vec2[surface.size()];
    for (int i = 0; i < vertices.length; i++) {
      vertices[i] = box2d.coordPixelsToWorld(surface.get(i));
    }
    chain.createChain(vertices, vertices.length);

    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.position.set(box2d.coordPixelsToWorld(x, y));

    body = box2d.createBody(bd);

    FixtureDef fd = new FixtureDef();
    fd.shape = chain;
    fd.density = 1;
    fd.friction = 0.5;
    fd.restitution = 0.5;

    body.createFixture(fd);
  
  }
  

  void display() {
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float angle = body.getAngle();
    fill(50);
    pushMatrix();
    beginShape();
    for(Vec2 v : surface){
      vertex(v.x, v.y);
    }
    vertex(width, height);
    vertex(0, height);
    endShape(CLOSE);
    popMatrix();
  }

  Vec2 getVec2() {
    Vec2 pos = box2d.getBodyPixelCoord(body);

    return pos;
  }
  
  void changeShape(){
    int size = (int)(width/spacing);
    surface.clear();
    float theta = angle;
    for(int i = 0; i<size; i++){
      
      surface.add(new Vec2(i * spacing, amp * sin(theta) + height/2));
      theta += dy;
    }
    angle += aV;
    if(body != null){
      kill();
    }
    makeOb();
  }
  
   void kill(){
    box2d.destroyBody(body);
  }
}
