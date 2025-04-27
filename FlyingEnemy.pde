class FlyingEnemy {
  PVector position;
  float speed;
  int enemyLevel = 0;
  float health;
  float size = 50;
  boolean isDead;
  float angleToPlayer;
  float radius;
  float hitstun = 0;

  FlyingEnemy() {
    position = new PVector();
    position.x = random(0, width);
    position.y = 0 - size;
    radius = size/2;
    if (scenePlay.level > 5) enemyLevel = 1;
    if (enemyLevel == 0) {
      speed = 200;
      health = 3;
    } else if (enemyLevel == 1) {
      speed = 250;
      health = 5;
    }
  }
  void update() {
    if (scenePlay != null) calcAngleToPlayer();
    hitstun -= dt;
    if (hitstun <= 0) {
      position.x += speed * cos(angleToPlayer) * dt;
      position.y += speed * sin(angleToPlayer) * dt;
    }
    if (health <= 0) {
      scenePlay.xp += 1;
      isDead = true;
    }
  }
  void draw() {
    if (enemyLevel == 0) {
      fill(0, 255, 255);
    } else if (enemyLevel == 1) {
      fill(255, 0, 255);
    }
    rect(position.x, position.y, size, size);
  }
  void calcAngleToPlayer() {
    float dx = scenePlay.player.position.x - position.x;
    float dy = scenePlay.player.position.y - position.y;
    angleToPlayer = atan2(dy, dx);
  }
}
