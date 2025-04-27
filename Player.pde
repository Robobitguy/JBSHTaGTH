class Player {
  PVector position;
  PVector speed;
  float size = 50;
  boolean jump = false;
  final int maxHealth = 3;
  int health = maxHealth;
  boolean isDead = false;
  float iFrameCD = 0;
  float weaponCD = 0;
  float pDirection = 1;
  float xPos, yPos;
  float weaponLength;
  int weaponLevel = 0;
  float radius;

  Player() {
    position = new PVector();
    speed = new PVector();
    position.x = width/2;
    position.y = height - 100;
    speed.x = 300;
    speed.y = 0;
    radius = size/2;
  }
  void update() {
    CalcWeaponPosition();
    weaponCD -= dt;
    iFrameCD -= dt;
    //MOVEMENT
    if (aKey) {
      position.x -= speed.x * dt;
      pDirection = -1;
    }
    if (dKey) {
      position.x += speed.x * dt;
      pDirection = 1;
    }
    if (wKey && jump == false) {
      speed.y = -500;
      jump = true;
    }
    if (spaceKey && weaponCD <=0) {
      weaponCD = 0.5;
      Weapon w = new Weapon (xPos, yPos);
      scenePlay.weapons.add(w);
    }
    speed.y += GRAVITY *dt;
    position.y += speed.y *dt;
    if (position.y > height - 175) {
      position.y = height - 175;
      jump = false;
    }
    if (position.x >= width - size) position.x = width - size;
    if (position.x <= 0) position.x = 0;
    if (health <= 0) {
      SwitchToGameOver();
    }
  }
  void draw() {
    pushMatrix();
    if (iFrameCD > 0) fill (0, 0, 255, 100);
    else fill(0, 0, 255);
    rect(position.x, position.y, size, size * 1.5);
    popMatrix();
  }
  void CalcWeaponPosition() {
    if (pDirection == -1) {
      xPos = position.x - weaponLength;
    } else if (pDirection == 1) {
      xPos = position.x + size;
    }
    yPos = position.y + 25;
  }
  void TakeDamage() {
    iFrameCD = 3;
    health--;
    weaponLevel = 0;
  }
}
