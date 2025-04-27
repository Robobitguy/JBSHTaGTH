class BounceEnemy {
  PVector position;
  PVector speed;
  Boolean isGrounded = true;
  float size = 50;
  float radius;
  boolean isDead;
  int spawnDirection;
  float health;
  float hitstun = 0;

  BounceEnemy() {
    position = new PVector();
    speed = new PVector();
    if (spawnDirection == 1) {
      position.x = 0 - size;
      speed.x = 400;
    } else if (spawnDirection == 2) {
      position.x = width + size;
      speed.x = -400;
    }
    position.y = height - 100 - size;
    radius = size/2;
    health = 3;
  }
  void update() {
    hitstun -= dt;
    if (hitstun <= 0) {
      position.x += speed.x * dt;
      speed.y += GRAVITY *dt;
      position.y += speed.y * dt;
    }
    if (position.y >= height - 100 - size) {
      isGrounded = true;
      position.y = height - 100 - size;
    }
    if (isGrounded == true) {
      speed.y -= 600;
      isGrounded = false;
    }
    if (position.x <= 0 + size) {
      position.x = 0 + size;
      speed.x = 400;
    }
    if (position.x >= width - size) {
      position.x = width - size;
      speed.x = -400;
    }
    if (health <= 0) isDead = true;
  }
  void draw() {
    fill (255, 255, 0);
    rect(position.x, position.y, size, size);
  }
}
