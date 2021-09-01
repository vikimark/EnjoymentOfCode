class Population {
  DNA[] genetic;
  ArrayList<DNA> matingPool;

  String target;
  float mutationRate;
  int popNum;

  boolean found;

  int generation;
  float bestFit;
  int indexBest;

  Population(String target_, int popNum_, float rate) {
    target = target_;
    popNum = popNum_;
    mutationRate = rate;
    matingPool = new ArrayList<DNA>();
    found = false;
    generation = 0;
    bestFit = 1;
    indexBest = 0;

    genetic = new DNA[popNum];
    initDNA();
  }

  void initDNA() {
    for (int i = 0; i < genetic.length; i++) {
      genetic[i] = new DNA(target.length());
    }
  }

  String allPhrase() {
    String everything = "";
    int start = (indexBest - 10 + genetic.length)%genetic.length;
    for (int i = start; i < start+24; i++) {
      everything += genetic[i%genetic.length].stringPhrase() + "\n";
    }

    return everything;
  }

  void selection() {
    matingPool.clear();

    for (int i = 0; i < genetic.length; i++) {
      genetic[i].calFitness(target);
    }
    evaluate();
    for (int i = 0; i < genetic.length; i++) {
      float fitness = map(genetic[i].fitness, 0, bestFit, 0, 1);
      int n = int(fitness * 500);
      for (int j = 0; j < n; j++)
        matingPool.add(genetic[i]);
    }
    //println(matingPool.size());
    //for(DNA d : matingPool){
    //  for(int j = 0; j < d.phrase.length; j++)
    //    print(d.phrase[j]);
    //    print("\n");
    //}
  }

  void dartingPoolSelection() {

    for (int i = 0; i < genetic.length; i++) {
      genetic[i].calFitness(target);
    }
    evaluate();

    float sum = 0;
    for (int i = 0; i < popNum; i++) {
      sum += genetic[i].fitness;
    }
    for (int i = 0; i < popNum; i++) {
      genetic[i].prob = genetic[i].fitness / sum; // cal probability
    }
  }

  DNA dartingPick(DNA[] list) {
    int index = 0;
    float r = random(1);
    while (r > 0) {
      r -= list[index].prob;
      if(index < popNum -1){
      index++;
      }
    }
    index--;
    return list[index];
  }

  void dartingPoolReproduction() {
    DNA[] child = new DNA[popNum];

    for (int i = 0; i < popNum; i++) {

      DNA a = dartingPick(genetic);
      DNA b = dartingPick(genetic);

      child[i] = a.crossover(a, b, mutationRate);
    }

    genetic = child;
  }

  void reproduction() {
    int ranA;
    int ranB;

    for (int i = 0; i < popNum; i++) {
      ranA = int(random(matingPool.size()));
      ranB = int(random(matingPool.size()));


      DNA a = matingPool.get(ranA);
      DNA b = matingPool.get(ranB);

      genetic[i] = a.crossover(a, b, mutationRate);
    }
  }

  String evaluate() {

    // !!! reset bestFit every time

    // confusing for hour display issue
    // have to reset value of bestFit
    // because in somewhat the next gen will score lower than previous gen
    // so it will display false String
    bestFit = 0;
    indexBest = 0;
    for (int i = 0; i < genetic.length; i++) {
      String a = genetic[i].stringPhrase();
      if (bestFit < genetic[i].fitness) {
        bestFit = genetic[i].fitness;
        indexBest = i;
      }

      if (a.equals(target)) {
        println("Found");
        found = true;
      }
    }
    return genetic[indexBest].stringPhrase();
  }

  float getAvFitness() {
    float total = 0;
    for (int i = 0; i < popNum; i++) {
      total += genetic[i].fitness;
    }
    return (total/(popNum));
  }

  void passDown() {
    generation++;
  }
}
