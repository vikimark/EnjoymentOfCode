class CA{
  int scl;
  int rows,cols;
  int rowsCount;
  int[] cells;
  
  int rules;
  
  int[] ruleset = {0, 0, 0, 1, 1, 1, 1, 0};
  
  CA(int scl_){
    scl = scl_;
    rows = height/scl;
    cols = width/scl;
    
    cells = new int[cols];
    cells[cols/2] = 1; // start with top center = 1
    
    rowsCount = 0;
    
    rules = 1;
    
    setRules(rules);
  }
  
  void nextGen(){
    int next[] = new int[cols];
    for(int j = 0; j < cells.length; j++){
      int before;
      int center;
      int front;
      
      if(j==0) before = cells[j];
       else before = cells[j-1];
       
       center = cells[j];
       
      if(j==cells.length - 1) front = cells[j];
      else front = cells[j+1];
      
      int index = before * 4 + center * 2 + front * 1;
      index = 7 - index; 
      
      next[j] = ruleset[index];
      }
      cells = next;
      rowsCount++;
  }
  
  void display(){
    noStroke();
    for(int i = 0; i < cells.length; i++){
      if(cells[i] == 1){fill(0);}
      else fill(255);
      
      rect(i * scl, rowsCount * scl, scl, scl);
    }
  }
  
  void ruleCheck(){
    if(rowsCount > rows){
       delay(1000);
       background(255);
       for(int i = 0; i < cells.length; i++)
       { if(i == cols/2) cells[i] = 1;
       else cells[i] = 0;
       }
       rowsCount = 0;
       rules++;
       if(rules > 255){
         rules = 0;
       }
       setRules(rules);
       
    }
  }
  
  void setRules(int r){
    for(int i = ruleset.length - 1; i >= 0; i--){
      ruleset[i] = (r >> ruleset.length - 1 - i) & 1;
    }
  }
}
