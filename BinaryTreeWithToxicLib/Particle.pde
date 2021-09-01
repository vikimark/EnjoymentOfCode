class Node extends VerletParticle2D{
  float value;
  Node left;
  Node right;
  
  Node(Vec2D loc, float val){
    super(loc);
    value = val;
    left = null;
    right = null;
  }
  
  void addNode(float val){
    Node n = new Node(new Vec2D(x, y + 20), val);
    
    if(val > value){
      if(right == null){
        n.x -= 200;
        right = n;
      }else right.addNode(val);
    }else if(val < value){
      if(left == null){
        n.x += 200;
        left = n;
      }else left.addNode(val);
    }
  }
  
  void visit(){
    if(left != null){
       left.visit(); 
    }
    println(value);
    if(right != null){
      right.visit();
    }
  }
  
  void toPhy(){
    physics.addParticle(this);
    physics.addBehavior(new AttractionBehavior2D(this, 40, -10));
    if(left != null){
      left.toPhy();
      physics.addSpring(new VerletSpring2D(this, left, 50, 1));
    }
    if(right != null){
      right.toPhy();
      physics.addSpring(new VerletSpring2D(this, right, 50, 1));
    }
  }
  
  void display(){
    fill(127, 80);
    stroke(0);
    strokeWeight(1);
    textAlign(CENTER);
    ellipse(x, y, 30, 30);
    fill(174, 0, 50);
    int temp = int(value);
    text(temp, x, y);
    if(left != null){
      line(x, y, left.x, left.y);
      left.display();
    }
    if(right != null){
      line(x, y, right.x, right.y);
      right.display();
    }
  }
}
