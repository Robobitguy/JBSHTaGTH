class PowerUp {
  int powerupType;
  float speed = 200;
  PVector position;
  float size = 50;
  float radius;
  boolean isDead;
  PowerUp() {
    position = new PVector();
    position.x = random(0 + size, width - size);
    powerupType = ceil(random(0, 3));
    radius = size/2;
    position.y = 0 - size;
  }
  void update() {
    position.y += speed *dt;
  }
  void draw() {
    if (powerupType == 1) {
      fill(#FF9599);
    } else if (powerupType == 2) {
      fill(0, 255, 0);
    } else if (powerupType == 3) {
      fill(0, 0, 255);
    }
    rect(position.x, position.y, size, size);
  }
}
