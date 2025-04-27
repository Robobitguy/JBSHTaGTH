class SceneTitle {
  SceneTitle() {
  }
  void update() {
    if (keyEnter) {
      SwitchToPlay();
    }
  }
  void draw() {
    background(0);
    pushMatrix();
    translate(width/2, height/2);
    scale (1.2,1.2);
    image (TitleBG, -TitleBG.width/2, -TitleBG.height/2);
    popMatrix();
    fill(0);
    textSize(30);
    textAlign(CENTER, CENTER);
    text("JOE BIDEN STUBS HIS TOE AND GOES TO HELL", width/2, height/2 - 30);
    textSize(20);
    text("Press ENTER to play!", width/2, height/2);
  }
}
