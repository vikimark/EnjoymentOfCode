class DNA {
  char[] phrase;
  float fitness;
  float prob;

  DNA(int len) {
    phrase = new char[len];
    randPhrase(phrase);
    prob = 0;
  }

  void randPhrase(char[] phrase) {
    for (int i = 0; i < phrase.length; i++) {
      phrase[i] = char(floor(random(32, 123)));
    }
  }

  String stringPhrase() {
    return new String(phrase);
  }

  void calFitness(String target) {
    int count = 0;
    for (int i = 0; i < phrase.length; i++) {
      if (phrase[i] == target.charAt(i))
        count++;
    }
    fitness = pow(2, count);
  }
  

  DNA crossover(DNA a, DNA b, float muteRate) {
    DNA child = new DNA(phrase.length);
    int middle = floor(random(1, a.phrase.length-1));
    for (int i = 0; i < phrase.length; i++) {
      if (i > middle)
        child.phrase[i] = b.phrase[i];
      else child.phrase[i] = a.phrase[i];
    }
    mutation(child, muteRate);

    return child;
  }

  void mutation(DNA child, float rate) {
    for (int i = 0; i < child.phrase.length; i++) {
      if (random(1) < rate) {
        child.phrase[i] = char(floor(random(32, 123)));
      }
    }
  }
}
