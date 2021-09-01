class GOL {

  int[][] board;
  int cols, rows;
  int res;

  GOL(int res_) {
    res = res_;
    cols = width/res;
    rows = height/res;

    board = new int[rows][cols];

    init();
  }

  void nextGen() {
    int next[][] = new int[rows][cols];
    for (int y = 0; y<rows; y++)
      for (int x = 0; x<cols; x++)
        next[y][x] = 0;

    //!!! important note
    //next = board; //why using this get error
    //  because next and board are pointer pointing to same direction if next were to change board will change too

    for (int y = 0; y < rows; y++) { //start at (1, 1)
      for (int x = 0; x < cols; x++) {

        //check neighbors
        int neighbors = 0;
        for (int i = -1; i<2; i++) {
          for (int j = -1; j<2; j++) {
            //if (i != 0 || j != 0) other option
            int indexX = (x + j + cols) % cols; //modulo trick
            int indexY = (y + i + rows) % rows; //modulo trick
            
            // UNOPTIMIZING way
            //if(indexX < 0)
            //  indexX += cols;
            //if(indexY < 0)
            //  indexY += rows;
            //if(indexX >= cols)
            //  indexX %= cols;
            //if(indexY >= rows)
            //  indexY %= rows;
            
            neighbors += board[indexY][indexX];
          }
        }
        neighbors -= board[y][x];
        next[y][x] = checkLife(board[y][x], neighbors);
      }
    }
    board = next;
  }

  int checkLife(int me, int neighbors) {

    if (me == 1 && neighbors < 2) return 0; //loneliness
    else if (me == 1 && neighbors > 3) return 0; //overpop
    else if (me == 0 && neighbors == 3) return 1;
    else return me; //statis
  }

  void display() {
    for (int y = 0; y < rows; y++) {
      for (int x = 0; x < cols; x++) {
        if (board[y][x] == 1) {
          fill(0);
        } else fill(255);

        rect(x * res, y * res, res, res);
      }
    }
  }

  void giveLife(float x, float y) {
    int xScl = int(x/res);
    int yScl = int(y/res);
    println(xScl, yScl);

    if (board[yScl][xScl] == 0) {
      board[yScl][xScl] = 1;
    } else board[yScl][xScl] = 0;
  }

  void init() {
    for (int y = 1; y < rows-1; y++)
      for (int x = 1; x < cols-1; x++) {
        board[y][x] = int(random(2));
      }
  }
}
