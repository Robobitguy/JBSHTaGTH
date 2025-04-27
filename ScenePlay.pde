class ScenePlay {

  //OBJECTS
  Player player;
  ArrayList<Weapon> weapons = new ArrayList();
  ArrayList<Enemy> enemies = new ArrayList();
  ArrayList<PowerUp> powerups = new ArrayList();
  ArrayList<FlyingEnemy> flyingEnemies = new ArrayList();
  ArrayList<BounceEnemy> bounceEnemies = new ArrayList();
  //SPAWNS
  float enemyCD = 1;
  float flyingEnemyCD = 1;
  float bounceEnemyCD = 1;
  //XP
  float xp;
  float xpNeeded;
  float level = 0;
  float xpBarMax;
  //MISC

  ScenePlay() {
    player =  new Player();
  }
  void update() {
    //SPAWN
    enemyCD -= dt;
    if (level >= 3) flyingEnemyCD -=dt;
    if (level > 5) bounceEnemyCD -=dt;
    if (enemyCD <= 0) {
      Enemy e = new Enemy();
      enemies.add(e);
      if (level < 3) enemyCD = random(3, 4);
      if (level >= 3) enemyCD = random(2, 3);
      if (level > 5) enemyCD = random(1, 2);
    }
    if (flyingEnemyCD <= 0) {
      FlyingEnemy f = new FlyingEnemy();
      flyingEnemies.add(f);
      if (level >= 3) flyingEnemyCD = random(7, 10);
      if (level > 5) flyingEnemyCD = random(5, 8);
    }
    if (bounceEnemyCD <= 0) {
      BounceEnemy b = new BounceEnemy();
      bounceEnemies.add(b);
      bounceEnemyCD = random(6,9);
    }
    //UPDATE
    player.update();
    xpBarMax = 600 * (xp / xpNeeded);
    xpNeeded = 4 + level;
    if (xp >= xpNeeded) {
      level += 1;
      xp = 0;
      PowerUp p = new PowerUp();
      powerups.add(p);
    }
    for (int i = 0; i < weapons.size(); i++) {
      Weapon w = weapons.get(i);
      w.update();
      for (int j = 0; j < enemies.size(); j++) {
        Enemy e = enemies.get(j);
        if (checkCollisionWeaponEnemy(w, e)) {
          e.health -= w.weaponDamage;
        }
      }
      for (int j = 0; j < flyingEnemies.size(); j++) {
        FlyingEnemy f = flyingEnemies.get(j);
        if (checkCollisionWeaponFlyingEnemy(w, f) && f.hitstun <= 0) {
          f.health -= w.weaponDamage;
          f.hitstun = 1;
        }
      }
      for (int j = 0; j < bounceEnemies.size(); j++) {
        BounceEnemy b = bounceEnemies.get(j);
        if (checkCollisionWeaponBounceEnemy(w, b) && b.hitstun <= 0) {
          b.health -= w.weaponDamage;
          b.hitstun = 1;
        }
      }
      if (w.isDead) weapons.remove(w);
    }
    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.update();
      if (checkCollisionPlayerEnemy(player, e)) {
        if (player.iFrameCD <= 0) player.TakeDamage();
      }
      if (e.spawnDirection == 1 && e.position.x >= width + e.size) e.isDead = true;
      if (e.spawnDirection == 2 && e.position.x <= 0 - e.size) e.isDead = true;
      if (e.isDead) enemies.remove(e);
    }
    for (int i = 0; i < flyingEnemies.size(); i++) {
      FlyingEnemy f = flyingEnemies.get(i);
      f.update();
      if (checkCollisionPlayerFlyingEnemy(player, f)) {
        if (player.iFrameCD <= 0) player.TakeDamage();
      }
      if (f.isDead) flyingEnemies.remove(f);
    }
    for (int i = 0; i < bounceEnemies.size(); i++) {
      BounceEnemy b = bounceEnemies.get(i);
      b.update();
      if (checkCollisionPlayerBounceEnemy(player, b)) {
        if (player.iFrameCD <= 0) player.TakeDamage();
      }
      if (b.isDead) bounceEnemies.remove(b);
    }
    for (int i = 0; i < powerups.size(); i++) {
      PowerUp p = powerups.get(i);
      p.update();
      if (checkCollisionPlayerPower(player, p)) {
        if (p.powerupType == 1) { //HEALTH
          if (player.health < 3) player.health++;
          else if (player.weaponLevel < 3) player.weaponLevel++;
          else player.iFrameCD = 10;
        }
        if (p.powerupType == 2) { //WEAPON
          if (player.weaponLevel < 3) player.weaponLevel++;
          else if (player.health < 3) player.health++;
          else player.iFrameCD = 10;
        }
        if (p.powerupType == 3) { //INVINCIBILITY
          player.iFrameCD = 10;
        }
        p.isDead = true;
      }
      if (p.position.y >= height + p.size) p.isDead = true;
      if (p.isDead) powerups.remove(p);
    }
  }
  void draw() {
    background (198, 80, 0);
    //ITEMS
    fill(255, 132, 0);
    rect(0, height-100, width, 100);
    for (int i = 0; i < enemies.size(); i++) {
      Enemy e = enemies.get(i);
      e.draw();
    }
    for (int i = 0; i < flyingEnemies.size(); i++) {
      FlyingEnemy f = flyingEnemies.get(i);
      f.draw();
    }
    for (int i = 0; i < bounceEnemies.size(); i++) {
      BounceEnemy b = bounceEnemies.get(i);
      b.draw();
    }
    for (int i = 0; i < powerups.size(); i++) {
      PowerUp p = powerups.get(i);
      p.draw();
    }
    for (int i = 0; i < weapons.size(); i++) {
      Weapon w = weapons.get(i);
      w.draw();
    }
    player.draw();
    //HUD
    stroke(3);
    textSize(25);
    noFill();
    rect(100, 50, 600, 50);
    fill(0, 255, 0);
    rect(100, 50, xpBarMax, 50);
    noStroke();

    fill(255, 0, 0);
    if (player.health >= 1) ellipse(50, 150, 50, 50);
    if (player.health >= 2) ellipse(50, 200, 50, 50);
    if (player.health >= 3) ellipse(50, 250, 50, 50);
  }
}
