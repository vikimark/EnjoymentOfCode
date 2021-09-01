class Grid {
  ArrayList<Particle> p;
  ArrayList<Connection> c;
  int w = 50;
  int h = 50;

  Grid() {
    p = new ArrayList<Particle>();
    c = new ArrayList<Connection>();


    for (int j = 0; j < h; j++) { // width
      for (int i = 0; i < w; i++) { // height
        p.add(new Particle(new Vec2D(width/20 + i * 10, height/20 + j * 10)));
        physics.addParticle(p.get(j * w + i));
      }
    }

    for (int rows = 0; rows < h; rows++) { // connect to left
      for (int column = 0; column < w-1; column++) {
        Particle p1 = p.get(column + rows * w);
        Particle p2 = p.get(column + 1 + rows * w);
        c.add(new Connection(p1, p2, 10, 1));
      }
    }

    for (int column = 0; column < w; column++) {
      for (int rows = 0; rows < h-1; rows++) {
        Particle p1 = p.get(column + rows * w);
        Particle p2 = p.get(column + (rows + 1) * w);
        c.add(new Connection(p1, p2, 10, 1));
      }

      for (int i = 0; i < c.size(); i++) {
        Connection s = c.get(i);
        physics.addSpring(s);
      }

      Particle p1 = p.get(0);
      Particle p2 = p.get(w-1);
      p1.lock();
      p2.lock();
    }
  }

  void display() {
    for (Connection a : c) {
      a.display();
    }
  }
}
