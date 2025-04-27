class SceneGameOver {
  SceneGameOver() {
  }
  void update() {
    if (spaceKey) SwitchToTitle();
  }
  void draw() {
    background(255, 0, 0);
    pushMatrix();
    translate(width/2, height/2 + 75);
    scale (0.8,0.8);
    image (GameOverBG, -GameOverBG.width/2, -GameOverBG.height/2);
    popMatrix();
    textSize(30);
    textAlign(CENTER, CENTER);
    fill(255);
    text("Press the spacebar to return to the main menu", width/2, height - 200);
  }
}
