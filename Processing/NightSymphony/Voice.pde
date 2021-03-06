class Voice {

  int readPort;
  int lightPort;
  float balance;

  boolean awoken = false;
  float wakeTime = 0;
  
  int[] filter = {0, 0, 0, 0, 0, 0 ,0 ,0, 0, 0, 0, 0, 0, 0 ,0 ,0};
  int filterIndex = 0;
  float filterAverage = 0;

  int[] notes = {
    1, 0, 1, 0, 1, 0, 1, 0
  };

  Voice(int voiceReadPort, int voiceLightPort, float voiceBalance, int[] voiceNotes ) {
    readPort = voiceReadPort;
    lightPort = voiceLightPort;
    balance = voiceBalance;
    
    if (voiceNotes != null) notes = voiceNotes;
  }
  
  void update() {
   
  
   
  }

  // This could be faster
  void updateFilter(int reading) {
   
    filter[filterIndex] = reading;
    filterIndex = (filterIndex + 1) % filter.length;
    
    float filterSum = 0;
    for (int i = 0; i < filter.length; i++) {
      filterSum += filter[i]; 
    }
    
    filterAverage = filterSum / filter.length;
         
  }

  boolean isAwake() {
    return awoken; 
  }
  
  void awake() {
    awoken = true;
    wakeTime = millis();
    arduino.analogWrite(lightPort, 255);
  }

  void sleep() {
    awoken = false; 
    arduino.analogWrite(lightPort, 0);
  }

  void setNotes (int[] noteTemplate) {

    for (int i = 0; i < noteTemplate.length; i++) {
      if (noteTemplate[i] == 0) {
        notes[i] = 0;
      } else {
        notes[i] = int(random(14));
      }
    }
  }
  
}

