class Enemy {
  int enemyLevel = 0;
  float health;
  int spawnDirection;
  PVector position;
  float speed;
  float size = 50;
  boolean isDead;
  float radius;
  Enemy() {
    position = new PVector();
    spawnDirection = ceil(random(0, 2));
    if (spawnDirection == 1) {
      position.x = 0 - size;
    } else if (spawnDirection == 2) {
      position.x = width + size;
    }
    position.y = height - 100 - size;
    //LEVEL CONDITIONS
    if (scenePlay.level > 3) enemyLevel = 1;
    if (scenePlay.level > 5) enemyLevel = 2;
    //LEVEL EFFECTS
    if (enemyLevel == 0) {
      if (spawnDirection == 1) speed = 300;
      else if (spawnDirection ==2) speed = -300;
      health = 1;
    } else if (enemyLevel == 1) {
      if (spawnDirection == 1) speed = 400;
      else if (spawnDirection ==2) speed = -400;
      health = 1;
    } else if (enemyLevel == 2) {
      if (spawnDirection == 1) speed = 450;
      else if (spawnDirection ==2) speed = -450;
      health = 1;
    }
    radius = size/2;
  }
  void update() {
    position.x += speed * dt;
    if (health <= 0) {
      scenePlay.xp += 1;
      isDead = true;
    }
  }
  void draw() {
    if (enemyLevel == 0) {
      fill(255, 0, 0);
    }
    if (enemyLevel == 1) {
      fill(100, 43, 5);
    }
    if (enemyLevel == 2) {
      fill(0, 0, 0);
    }
    rect(position.x, position.y, size, size);
  }
}
