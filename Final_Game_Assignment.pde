import g4p_controls.*; 
import java.awt.Font;
GButton play, howTo, back, leave, round2, round3, playAgain;
import ddf.minim.*;
Minim minim;
AudioPlayer explosionSound, introMusic, roundOneMusic, roundTwoMusic, roundThreeMusic, missileSound1, missileSound2, fireballSound1, fireballSound2, tutorialMusic, player1Scores, player2Scores, victory1, victory2;
PImage startingScreen, spaceWord, warsWord, WASD, arrowKeys, roundOneBack, roundTwoBack, roundThreeBack;
PImage score1, score2, player1winner, player2winner, player1ending, player2ending, redArrow;
PImage Plane1, Plane2, Plane3, space, missile, explosion, fireball;
PImage explode1, explode2, explode3, explode4, explode5;
PImage blueExplode1, blueExplode2, blueExplode3, blueExplode4, blueExplode5;
PFont tutorialFont;
int hp1 = 100, hp2 = 100, playerTotal1, playerTotal2, round = 0;
int frame = 1, frame2 = 1, explodeFrame1 = 1, explodeFrame2 = 1; 
boolean start = false, tutorial = false, Score = false;
boolean fireballFired1 = false, fireballFired2 = false, missileFired1 = false, missileFired2 = false;
boolean up1 = false, down1 = false, up2 = false, down2 = false, fly = false, fly2 = false;
boolean roundOneScene = true, roundTwoScene = false, roundThreeScene = false, nextRound1 = false, nextRound2 = false; 
float missileX = 0, missileY = 0, y1 = 300, missileX2 = 0, missileY2 = 0, y2 = 300; 
float d1, d2, d3, d4, hit1 = 0, hit2 = 0; 
float red1 = 0, green1 = 255, blue1 = 0, red2 = 0, green2 = 255, blue2 = 0 ;
float rTotal1 = 255, bTotal1 = 255, rTotal2 = 255, bTotal2 = 255;
float fireballY1 = 0, fireballY2 = 0;
float rotation1 = 10, rotation2 = 10, speed = 350;
float addY1, addY2;

void setup() {
  size(1000, 700);  // 
  smooth();
  minim = new Minim(this);
  startingScreen = loadImage("start.jpg");
  Plane1 = loadImage("plane1.png");
  Plane2 = loadImage("plane2.png");
  Plane3 = loadImage("plane3.png");
  WASD = loadImage("WASD.png");
  arrowKeys = loadImage("arrowKeys.png");
  missile = loadImage("missile.png");
  spaceWord = loadImage("space.png");
  warsWord = loadImage("wars copy.png");
  fireball = loadImage("fireball.gif");
  explode1 = loadImage("explosion1.png");
  explode2 = loadImage("explosion2.png");
  explode3 = loadImage("explosion3.png");
  explode4 = loadImage("explosion4.png");
  explode5 = loadImage("explosion5.png");
  blueExplode1 = loadImage("blueExplosion1.png");
  blueExplode2 = loadImage("blueExplosion2.png");
  blueExplode3 = loadImage("blueExplosion3.png");
  blueExplode4 = loadImage("blueExplosion4.png");
  blueExplode5 = loadImage("blueExplosion5.png");
  redArrow = loadImage("redArrow.png");
  score1 = loadImage ("SCORE.jpg");
  score2 = loadImage ("SCORE2.jpg");
  player1winner = loadImage("player1wins.png");
  player2winner = loadImage("player2wins.png");
  player1ending = loadImage("1winbackground.jpg");
  player2ending = loadImage("2winbackground.jpg");
  explosionSound = minim. loadFile("explosionSound.mp3");
  introMusic = minim. loadFile("introMusic.mp3");
  tutorialMusic = minim. loadFile("tutorialMusic.mp3");
  missileSound1 = minim. loadFile("missileSound.mp3");
  missileSound2 = minim. loadFile("missileSound.mp3");
  fireballSound1 = minim. loadFile("fireballSound.mp3");
  fireballSound2 = minim. loadFile("fireballSound.mp3");
  player1Scores = minim. loadFile("player1Scores.mp3");
  player2Scores = minim. loadFile("player2Scores.mp3");
  victory1 = minim. loadFile("player1wins.mp3");
  victory2 = minim. loadFile("player2wins.mp3");
  roundOneMusic = minim. loadFile("roundOneMusic.mp3");
  roundTwoMusic = minim. loadFile("roundTwoMusic.mp3");
  roundThreeMusic = minim. loadFile("roundThreeMusic.mp3");
  roundOneBack = loadImage("roundOneScene.jpg");
  roundTwoBack = loadImage("roundTwoScene.jpg");
  roundThreeBack = loadImage("roundThreeScene.jpg");
  tutorialFont = createFont("Trebuchet MS", 35);
  play = new GButton(this, 260, 450, 220, 100, "Start");
  play.setFont(new Font("Trebuchet MS", Font.PLAIN, 80));
  howTo = new GButton(this, 510, 450, 220, 100, "How To Play?");
  howTo.setLocalColorScheme(int(random(0, 2))); 
  howTo.setFont(new Font("Trebuchet MS", Font.PLAIN, 40));
  back = new GButton(this, 30, 15, 120, 50, "Back"); 
  back.setVisible(false);
  back.setFont(new Font("calibri", Font.PLAIN, 40));
  round2 = new GButton(this, 740, 10, 220, 85, "Round Two");
  round2.setVisible(false);
  round2.setFont(new Font("Trebuchet MS", Font.PLAIN, 40));
  round3 = new GButton(this, 740, 10, 220, 85, "Round Three");
  round3.setVisible(false);
  round3.setFont(new Font("Trebuchet MS", Font.PLAIN, 35));
  playAgain = new GButton(this, 740, 10, 220, 85, "Play Again?");
  playAgain.setVisible(false);
  playAgain.setFont(new Font("Trebuchet MS", Font.PLAIN, 40));
  leave = new GButton(this, 40, 10, 220, 85, "Exit?");
  leave.setVisible(false);
  leave.setFont(new Font("Trebuchet MS", Font.PLAIN, 80));
}

void draw() {
  if (start == false && playerTotal1 == 0 && playerTotal2 == 0) {  // Loads the start screen before the user presses play
    introMusic.play();
    image(startingScreen, 0, 0); 
    image(spaceWord, width/4 - 50, 50, 600, 180);
    image(warsWord, width/4 + 30, 220, 450, 140);
  }
  if (start == true) {   
    introMusic.rewind(); // Resets the introduction music 
    introMusic.pause();
    if (roundOneScene == true) {
      image(roundOneBack, -150, 0, 1250, height); 
      roundOneMusic.play();
    } else if (roundTwoScene == true) {            // Loads different background images and music depending on which 'round' the users are fighting in.
      image(roundTwoBack, 0, 0, width, height); 
      roundTwoMusic.play();
    } else if (roundThreeScene == true) {
      image(roundThreeBack, -200, 0, 1400, height);
      roundThreeMusic.play();
    }
    fill(red1, green1, blue1);
    rect(50, (y1 + 15), hp1, 10); 
    fill(red2, green2, blue2);
    rect(850, (y2 + 15), hp2, 10);
    fill(rTotal1, 255, bTotal1);
    ellipse(165, (y1 + 20), 12, 12);      // Displays the health points of each player. Variables in the 'fill' will change if collision is detected.
    fill(255, 255, 255);                  // Also displays the amount of points each player has as ellipses. The colours in some ellipses will change as well.
    ellipse(182, (y1 + 20), 12, 12);
    fill(255, 255, 255);
    ellipse(835, (y2 + 20), 12, 12);
    fill(rTotal2, 255, bTotal2);
    ellipse(818, (y2 + 20), 12, 12);
    fly();                                // The fly() function animates the planes depending on the direction that they travel in.
    fly2();
    if (missileFired1 == true) {
      missileSound1.play();
      image(missile, missileX, missileY + 40, 127, 87);   // Loads a missile that travels at a constant speed straight left and shoots from the previous location of the player's plane.
      missileX += 40;
    }
    if (missileX >= 900) {
      missileSound1.rewind();     // Once the missile passes 900 units to the left or right, the sound for when the missile is launched is reset.
      missileSound1.pause();
    }
    if ( missileFired2 == true) {
      missileSound2.play();
      pushMatrix();
      translate(950, 350);    // Shoots a missile that is flipped and travelling to the right at the same speed. 
      scale(-1, 1);
      image(missile, missileX2, missileY2 - 325, 127, 87);
      popMatrix();
      missileX2 += 40;
    }
    if (missileX2 >= 900) {
      missileSound2.rewind();  
      missileSound2.pause();
    }
    d1 = dist(missileX, missileY, 810, y2 - 20);   // The 'dist' between the missiles and the location of the opponent's y-location.
    d2 = dist(missileX2, missileY2, 810, y1);

    if ( d1 < 30) {
      explosionSound.rewind();
      explosionSound.pause();
      missileSound1.rewind();
      missileSound1.pause();          // Collision detection for the missiles and adding sound features as well.
      hit1++;
      explodeFrame2 = 1;
      missileFired1 = false;
      missileX = 0;
    }
    if ( d2 < 30) {
      explosionSound.rewind();
      explosionSound.pause();
      missileSound2.rewind();
      missileSound2.pause();
      hit2++;
      explodeFrame1 = 1;
      missileFired2 = false;
      missileX2 = 0;
    }

    int x = 0, y = 0;
    rotation1 += 0.06;   
    pushMatrix();
    if (fireballFired1 == false) { // prevents the energy ball from following the 'y1' of the plane by only adding zero to the y-Loc once it gets fired. 
      addY1 = y1;
      addY1 += 0;
    }
    if (fireballFired1 == true) {
      fireballSound1.play();
      translate(width/2 - 50, fireballY1); // Rotates the fireball clockwise or counter-clockwise using cosine and sine law.
      x += cos(rotation1) * speed;
      y += sin(rotation1) * speed;
      image(fireball, x, y, 80, 80);
    }
    if (rotation1 > 2*PI) {     // stops the rotation of the fireball once it reaches 2-Pi radians or around 180 degrees.
      fireballFired1 = false;
    }
    if (fireballFired1 == false) {  
      fireballSound1.rewind();    // resets the sound of the fireball being fired when it is not being fired.
      fireballSound1.pause();
    } 
    d3 = dist(x, y + addY1, 320, y2); 
    if (d3 < 50) {
      explosionSound.play();
      hit1++;
      explosionSound.rewind();  // Collision detection for the fireball and adding explosion sounds once collision has been detected.
      explosionSound.pause();
      explodeFrame2 = 1;
      rotation1 = PI;
      fireballFired1 = false;
    }
    popMatrix();
    int a = 0, b = 0;
    rotation2 += -0.06;
    pushMatrix();
    if (fireballFired2 == false) { 
      addY2 = y2; 
      addY2 += 0;
    }
    if (fireballFired2 == true) {     // repeating the collision detection, sound, and movement for player 2's fireball
      fireballSound2.play();
      translate(width/2 - 50, fireballY2);
      a += cos(rotation2) * speed;
      b += sin(rotation2) * speed;
      image(fireball, a, b, 80, 80);
    }
    if (rotation2 < -PI) {
      fireballFired2 = false;
    }
    if (fireballFired2 == false) {
      fireballSound2.rewind();
      fireballSound2.pause();
    }
    d4 = dist(a, b + addY2, -310, y1);
    if (d4 < 50) {
      explosionSound.rewind();
      explosionSound.pause();
      hit2++;
      explodeFrame1 = 1;
      rotation2 = 0;
      fireballFired2 = false;
    }
    popMatrix();

    if (hit1 == 1) {
      red2 = 255;
      green2 = 255;
      explodePlane2();
      explosionSound.play();
    } else if (hit1 == 2) {
      green2 = 90;
      explodePlane2();
      explosionSound.play();         // changing the colours of the player's health points depending on how many 'hits' they have taken
    } else if (hit1 == 3) {
      green2 = 0;
      explodePlane2();               // playing more sound effects if they have been hit by the missiles or fireballs. 
      explosionSound.play();
    } else if (hit1 >= 4) {
      explodePlane2();
      explosionSound.play();
      start = false;
      nextRound1 = true;
      playerTotal1++;               // adding to a scoreboard for future use
      round++;
    }
    if (hit2 == 1) {
      red1 = 255;
      green1 = 255;
      explodePlane1();
      explosionSound.play();
    } else if (hit2 == 2) {
      green1 = 90;
      explodePlane1();
      explosionSound.play();        // repeat for the second player
    } else if (hit2 == 3) {
      green1 = 0;
      explodePlane1();
      explosionSound.play();
    } else if (hit2 >= 4) {
      start = false;
      explodePlane1();
      explosionSound.play();
      nextRound2 = true;
      playerTotal2++;
      round++;
    }
    if (nextRound1 == true && playerTotal1 == 1) {
      roundSoundReset();
      Score = true;
      rTotal1 = 0;
      bTotal1 = 0;
      image(score1, 0, 0, 1000, 700);          // If player 1 defeats player 2 in the first round, a scoreboard appears and the players can move onto round 2 by clicking a button that also appears.
      player1Scores.play();
      round2.setVisible(true);
      leave.setVisible(true);
    }
    if (nextRound2 == true && playerTotal2 == 1) {
      roundSoundReset();
      Score = true;
      rTotal2 = 0;
      bTotal2 = 0;
      image(score2, 0, 0, 1000, 700);  // If player 2 defeats player 1, the same scoreboard and button appears but with different music and background.
      player2Scores.play();
      round2.setVisible(true);
      leave.setVisible(true);
    }
    if (playerTotal1 == 1 && playerTotal2 == 1 && roundThreeScene == false) {
      roundSoundReset();
      round3.setVisible(true);   // If the players tie after round two, they can move on to the tiebreaker in round three which is the final round. 
    } else {
      round3.setVisible(false);
    }
    if (playerTotal1 == 2) {
      roundSoundReset();
      victory1.play();
      playAgain.setVisible(true);  // This plays victory music if any of the players win with two points.
      leave.setVisible(true);
    }
    if (playerTotal2 == 2) {
      roundSoundReset();
      victory2.play(); 
      playAgain.setVisible(true); 
      leave.setVisible(true);
    }
    if (playerTotal1 == 2) {
      roundSoundReset();
      image(player1ending, 0, 0, 1000, 700); // This is the visual aspect for the players' victory
      image(player1winner, 75, 550);
      playAgain.setVisible(true);
      leave.setVisible(true);
    }
    if (playerTotal2 == 2) {
      roundSoundReset();
      image(player2ending, -100, 0, 1200, 700 ); 
      image(player2winner, 75, 550);
      playAgain.setVisible(true);
      leave.setVisible(true);
    }
    if (Score == true) {  // This is the visual aspect of the scoreboard after round one and two.
      noStroke();
      fill(#0B57B7, 200);
      rect(50, 325, 300, 300, 15);
      rect(650, 325, 300, 300, 15);
      rect(73, 210, 250, 100, 15);
      rect(675, 210, 250, 100, 15);
      rect(400, 300, 200, 200, 15);
      rect(400, 510, 200, 75, 15);
      fill(255);
      textFont(tutorialFont, 60);
      text("Player 1", 91, 280);
      text("Player 2", 691, 280);
      text("Round", 418, 570);
      textFont(tutorialFont, 275);
      text("0" + playerTotal1, 57, 585);
      text("0" + playerTotal2, 658, 585);
      textFont(tutorialFont, 200);
      text(round, 448, 470);
    }
    if (up1 == true) {
      y1 -= 20;
    } else if (down1 == true) {  // moves the y-location of the players' planes when keys are pressed to trigger the booleans.
      y1 += 20;
    } 
    if (up2 == true) {
      y2 -= 20;
    } else if (down2 == true) {        
      y2 += 20;
    } 
    if (y1 < -15) {
      y1 += 20;
    } else if (y1 > 605) {     // Edge-detection for the players' planes.
      y1 -= 20;
    } 
    if (y2 < -15) {
      y2 += 20;
    } else if (y2 > 605) {
      y2 -= 20;
    }
    if (missileX > 1000) {
      missileFired1 = false;  // resets the x-locations of the missiles once they travel off-screen.
      missileX = 0;
    }
    if (missileX2 > 1000) {
      missileFired2 = false; 
      missileX2 = 0;
    }
  }
  if (tutorial == true) {  // This is everything in the tutorial section which teaches the controls and goal of the game.
    introMusic.rewind();
    introMusic.pause();
    image(roundOneBack, -150, 0, 1250, height); 
    noStroke();
    fill(0, 0, 255, 150);
    rect(50, 225, 450, 420, 15);
    fill(255, 0, 0, 150);
    rect(500, 225, 450, 420, 15);
    image(Plane1, 30, 85, 180, 180); 
    pushMatrix();
    translate(1800, -15);
    scale(-1, 1);
    image(Plane1, 830, 100, 180, 180);
    popMatrix();
    fill(0, 255, 0);
    rect(50, 120, hp1, 10); 
    rect(850, 120, hp2, 10);
    image(WASD, 150, 350, 250, 170);
    image(arrowKeys, 600, 350, 250, 170);
    fill(255);
    ellipse(165, 125, 12, 12);
    ellipse(182, 125, 12, 12);
    ellipse(835, 125, 12, 12);
    ellipse(818, 125, 12, 12);
    fill(#095E95, 230);
    rect(250, 55, 500, 110, 15);
    fill(255);
    textFont(tutorialFont, 25);
    text("Shoot down your opponent with four hits.", 265, 95);
    text("Win two out of three rounds to win.", 298, 137);
    image(redArrow, 195, 105, 100, 50);
    pushMatrix();
    translate(805, 106);
    scale(-1, 1);
    image(redArrow, 0, 0, 100, 50);
    popMatrix();
    textFont(tutorialFont, 35);
    fill(255);
    text("Player 1", 42, 105);
    text("Player 2", 840, 105);
    text("W to move up", 170, 280);
    text("S to move down", 153, 320);
    text("'Up' to move up", 603, 280);
    text("'Down' to move down", 560, 320);
    fill(255, 100, 0);
    text("A to fire a missile", 132, 570);
    text("D to fire an energy ball", 92, 610);
    fill(#FFFA64);
    text("'Left' to fire a missile", 558, 570);
    text("'Right' to fire an energy ball", 507, 610);
  }
}

void keyPressed() {  
  if (start == true) {
    if (key == 'w' || key == 'W') {  // pressing W or the up arrow key will move the plane up and change the frame of the plane's animation
      frame = 2;
      up1 = true;
      fly = true;
    } else if (key == 's' || key == 'S') { // pressing S or the down arrow key will move the plane up and change the frame of the plane's animation
      frame = 1;
      down1 = true;
      fly = true;
    } 
    if (key == 'a' || key == 'A') { // Pressing A or the left arrow key will fire a missile to the left or right.
      missileFired1 = true;
      if (missileX < 151) {
        Missile1();
      }
    } 
    if (key == 'd' || key == 'D') { // Pressing D or the right arrow key will fire a fireball.

      if (start == true) {
        fireball1();
      }
      if (fireballFired1 == false) {
        rotation1 = PI;
      }
      fireballFired1 = true;
    }
    if (keyCode == UP) {
      frame2 = 2;
      up2 = true;
      fly2 = true;
    } else if (keyCode == DOWN) {
      frame2 = 1;
      down2 = true;
      fly2 = true;
    }
    if (keyCode == LEFT ) {
      missileFired2 = true;
      if (missileX2 < 151) {
        Missile2();
      }
    }
    if (keyCode == RIGHT) {
      if (start == true) {
        fireball2();
      }
      if (fireballFired2 == false) {
        rotation2 = 0;
      }
      fireballFired2 = true;
    }
  }
}

void keyReleased() { // releasing these keys will stop the actions occurring in void keyPressed.
  if (start == true) {
    if (key == 'w' || key == 'W') {
      up1 = false;
      fly = false;
    } else if (key == 's' || key == 'S') {
      down1 = false;
      fly = false;
    } 
    if (keyCode == UP) {
      up2 = false;
      fly2 = false;
    } else if (keyCode == DOWN) {
      down2 = false;
      fly2 = false;
    }
  }
}

void Missile1 () {  // Prevents the y-location of the missile/fireball from following the y-location of the plane after being launched
  missileY = y1;
  missileY += 0;
}

void Missile2() {
  missileY2 = y2; 
  missileY2 += 0;
}

void fireball1() {
  if (fireballFired1 == false) { 
    fireballY1 = y1;
  }
  fireballY1 += 0;
}

void fireball2() {
  if (fireballFired2 == false) {
    fireballY2 = y2;
  }
  fireballY2 += 0;
}

void fly() {
  if (fly == false) {
    image(Plane1, 30, y1 - 15, 180, 180); // Animation of the planes depending on keys being pressed to trigger these booleans.
  }
  if (fly == true && frame == 1) {
    image(Plane2, 30, y1 - 15, 180, 180);
  } else if (fly == true && frame == 2) {
    image(Plane3, 30, y1 - 15, 180, 180);
  }
}

void fly2() {
  if (fly2 == false) {
    pushMatrix();
    translate(1800, -15);
    scale(-1, 1);
    image(Plane1, 830, y2, 180, 180);
    popMatrix();
  }

  if (fly2 == true && frame2 == 1) {
    pushMatrix();
    translate(1800, -15);
    scale(-1, 1);
    image(Plane2, 830, y2, 180, 180);
    popMatrix();
  } else if (fly2 == true && frame2 == 2) {
    pushMatrix();
    translate(1800, -15);
    scale(-1, 1);
    image(Plane3, 830, y2, 180, 180);
    popMatrix();
  }
}

void explodePlane1() {
  if (explodeFrame1 == 1) {
    image(explode1, 45, y1 - 40);      // The animation of the explosions when a plane is hit by anything.
    explodeFrame1++;
  } else if (explodeFrame1 == 2) {
    image(explode2, 45, y1 - 40); 
    explodeFrame1++;
  } else if (explodeFrame1 == 3) {
    image(explode3, 45, y1 - 40); 
    explodeFrame1++;
  } else if (explodeFrame1 == 4) {
    image(explode4, 45, y1 - 40); 
    explodeFrame1++;
  } else if (explodeFrame1 == 5) {
    image(explode5, 45, y1 - 40);
    explodeFrame1++;
  } else if (explodeFrame1 == 6) {
    explodeFrame1 = 0;
  }
}

void explodePlane2() {
  if (explodeFrame2 == 1) {
    image(blueExplode1, 745, y2 - 40); 
    explodeFrame2++;
  } else if (explodeFrame2 == 2) {
    image(blueExplode2, 745, y2 - 40); 
    explodeFrame2++;
  } else if (explodeFrame2 == 3) {
    image(blueExplode3, 745, y2 - 40); 
    explodeFrame2++;
  } else if (explodeFrame2 == 4) {
    image(blueExplode4, 745, y2 - 40); 
    explodeFrame2++;
  } else if (explodeFrame2 == 5) {
    image(blueExplode5, 745, y2 - 40);
    explodeFrame2++;
  } else if (explodeFrame2 == 6) {
    explodeFrame2 = 0;
  }
}

void handleButtonEvents(GButton button, GEvent event) {  
  if (button == play && event == GEvent.CLICKED) {
    play.setVisible(false);   
    howTo.setVisible(false);
    start = true;
  } else if (button == howTo && event == GEvent.CLICKED) {
    tutorialMusic.play();
    howTo();
  } else if (button == back && event == GEvent.CLICKED) {
    tutorialMusic.rewind();
    tutorialMusic.pause();
    back();
  } else if (button == leave && event == GEvent.CLICKED) {
    exit();
  } else if (button == round2 && event == GEvent.CLICKED) {
    reset();
  } else if (button == round3 && event == GEvent.CLICKED) {
    reset();
  } else if (button == playAgain && event == GEvent.CLICKED) {
    reset();
  }
}

void howTo() { // takes the player to the tutorial.
  howTo.setVisible(false); 
  play.setVisible(false);
  back.setVisible(true);
  tutorial = true;
}

void back() { // returns the player back to the introduction from the tutorial
  tutorial = false;
  back.setVisible(false);       
  howTo.setVisible(true);
  play.setVisible(true);
}

void reset() { // resets every variable in the game so that it can be played again.
  if (playerTotal1 == 1 || playerTotal2 == 1) {
    roundOneScene = false;
    roundTwoScene = true;
  }
  if (playerTotal1 == 1 && playerTotal2 == 1) {
    roundTwoScene = false;
    roundThreeScene = true;
  }
  if (playerTotal1 == 2 || playerTotal2 == 2) {
    roundThreeScene = false;
    roundOneScene = true;
    playerTotal1 = 0;
    playerTotal2 = 0;
    round = 0;
    rTotal1 = 255;
    bTotal1 = 255;
    rTotal2 = 255;
    bTotal2 = 255;
  }
  player1Scores.rewind();
  player1Scores.pause();
  player2Scores.rewind();
  player2Scores.pause();
  victory1.rewind();
  victory1.pause();
  victory2.rewind();
  victory2.pause();
  Score = false;
  nextRound1 = false;
  nextRound2 = false;
  round2. setVisible(false);
  playAgain.setVisible(false);
  leave.setVisible(false);
  hit1 = 0;
  hit2 = 0;
  red1 = 0;
  red2 = 0;
  green1 = 255;
  green2 = 255;
  y1 = 300;
  y2 = 300;
  missileX = 0;
  missileY = 0;
  missileX2 = 0;
  missileY2 = 0;
  fly = false;
  fly2 = false;
  missileFired1 = false;
  missileFired2 = false;
  fireballFired1 = false;
  fireballFired2 = false;
  up1 = false;
  up2 = false;
  down1 = false;
  down2 = false;
  start = true;
}

void roundSoundReset() {   // resets the music for all rounds.
  roundOneMusic.rewind();
  roundOneMusic.pause();
  roundTwoMusic.rewind();
  roundTwoMusic.pause();
  roundThreeMusic.rewind();
  roundThreeMusic.pause();
}
