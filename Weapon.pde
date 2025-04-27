class Weapon {

  float weaponTimer = 0.2;
  boolean isDead = false;
  float weaponDamage;
  PVector wPos;
  Weapon(float xPos, float yPos) {
    wPos = new PVector();
    wPos.x = xPos;
    wPos.y = yPos;
  }
  void update() {
    weaponTimer -= dt;
    if (scenePlay != null) {
      if (weaponTimer <= 0) isDead = true;

      if (scenePlay.player.weaponLevel == 0) {
        scenePlay.player.weaponLength = 75;
        weaponDamage = 1;
      } else if (scenePlay.player.weaponLevel == 1) {
        scenePlay.player.weaponLength = 100;
        weaponDamage = 1;
      } else if (scenePlay.player.weaponLevel == 2) {
        scenePlay.player.weaponLength = 100;
        weaponDamage = 2;
      } else if (scenePlay.player.weaponLevel == 3) {
        scenePlay.player.weaponLength = 150;
        weaponDamage = 3;
      }
    }
  }
  void draw() {
    if (scenePlay.player.weaponLevel == 0) {
      fill(100, 58, 17);
    } else if (scenePlay.player.weaponLevel == 1) {
      fill (0, 0, 0);
    } else if (scenePlay.player.weaponLevel == 2) {
      fill(170, 170, 170);
    } else if (scenePlay.player.weaponLevel == 3) {
      fill(255, 0, 255);
    }
    rect(wPos.x, wPos.y, scenePlay.player.weaponLength, 10);
  }
}
