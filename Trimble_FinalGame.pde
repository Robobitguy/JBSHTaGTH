//this program plays an arcade game
//copyright Aiden Trimble 2024
//CONTROLS
//A+D - move left/right
//W - Jump
//Spacebar - attack
//POWERUPS
//RED - restores 1 health
//GREEN - upgrades weapon by 1
//BLUE - 10 seconds of invincibility
//if health or weapon is maxxed out, it gives the opposite effect, if both are maxxed out, gives the invincibility.

float dt;
float prevTime = 0;
final float GRAVITY = 981;
//SCENES
SceneTitle sceneTitle;
ScenePlay scenePlay;
SceneGameOver sceneGameOver;
//CONTROLS
boolean keyEnter = false;
boolean wKey, aKey, dKey, sKey, qKey, spaceKey;
boolean leftPressed, pLeftPressed;
//PICTURES
PImage TitleBG;
PImage GameOverBG;
//MISC

void setup() {
  size(800, 600);
  SwitchToGameOver();
  noStroke();
  TitleBG = loadImage("Joe.jpg");
  GameOverBG = loadImage("Joever.jpg");
}

void draw() {
  calcDeltaTime();
  if (sceneTitle != null) {
    sceneTitle.update();
    if (sceneTitle != null) sceneTitle.draw();
  } else if (scenePlay != null) {
    scenePlay.update();
    if (scenePlay != null) scenePlay.draw();
  } else if (sceneGameOver != null) {
    sceneGameOver.update();
    if (sceneGameOver != null) sceneGameOver.draw();
  }
}

void calcDeltaTime() {
  float currTime = millis() / 1000.0; // Gets and stores the current time stamp.
  dt = currTime - prevTime;
  prevTime = currTime; // Setup prevTime to be equal to current time for next frame.
}

void SwitchToTitle() {
  sceneTitle = new SceneTitle();
  scenePlay = null;
  sceneGameOver = null;
}
void SwitchToPlay() {
  scenePlay = new ScenePlay();
  sceneTitle = null;
  sceneGameOver = null;
}
void SwitchToGameOver() {
  sceneGameOver = new SceneGameOver();
  scenePlay = null;
  sceneTitle = null;
}

void keyPressed() {
  //println(keyCode);
  if (keyCode == 10) keyEnter = true;
  if (keyCode == 65) aKey = true;
  if (keyCode == 68) dKey = true;
  if (keyCode == 83) sKey = true;
  if (keyCode == 87) wKey = true;
  if (keyCode == 81) qKey = true;
  if (keyCode == 32) spaceKey = true;
}
void keyReleased() {
  if (keyCode == 10) keyEnter = false;
  if (keyCode == 65) aKey = false;
  if (keyCode == 68) dKey = false;
  if (keyCode == 83) sKey = false;
  if (keyCode == 87) wKey = false;
  if (keyCode == 81) qKey = false;
  if (keyCode == 32) spaceKey = false;
}
//COLLISIONS
boolean checkCollisionPlayerEnemy(Player a, Enemy b) {
  float dx = b.position.x - a.position.x;
  float dy = b.position.y - a.position.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}
boolean checkCollisionPlayerFlyingEnemy(Player a, FlyingEnemy b) {
  float dx = b.position.x - a.position.x;
  float dy = b.position.y - a.position.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}
boolean checkCollisionPlayerBounceEnemy(Player a, BounceEnemy b) {
  float dx = b.position.x - a.position.x;
  float dy = b.position.y - a.position.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}
boolean checkCollisionWeaponEnemy(Weapon a, Enemy b) {
  if (scenePlay != null) {
    float dx = b.position.x - a.wPos.x;
    float dy = b.position.y - a.wPos.y;
    float dis = sqrt(dx * dx + dy * dy);
    if (dis <= (scenePlay.player.weaponLength * 0.9) + b.radius) return true;
  }
  return false;
}
boolean checkCollisionWeaponFlyingEnemy(Weapon a, FlyingEnemy b) {
  if (scenePlay != null) {
    float dx = b.position.x - a.wPos.x;
    float dy = b.position.y - a.wPos.y;
    float dis = sqrt(dx * dx + dy * dy);
    if (dis <= (scenePlay.player.weaponLength * 0.9) + b.radius) return true;
  }
  return false;
}
boolean checkCollisionWeaponBounceEnemy(Weapon a, BounceEnemy b) {
  if (scenePlay != null) {
    float dx = b.position.x - a.wPos.x;
    float dy = b.position.y - a.wPos.y;
    float dis = sqrt(dx * dx + dy * dy);
    if (dis <= (scenePlay.player.weaponLength * 0.9) + b.radius) return true;
  }
  return false;
}
boolean checkCollisionPlayerPower(Player a, PowerUp b) {
  float dx = b.position.x - a.position.x;
  float dy = b.position.y - a.position.y;
  float dis = sqrt(dx * dx + dy * dy);
  if (dis <= a.radius + b.radius) return true;
  return false;
}
