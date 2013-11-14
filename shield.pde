import java.util.Iterator;
import java.util.Map;
import java.util.concurrent.ConcurrentMap;
import java.util.concurrent.ConcurrentHashMap;

import com.leapmotion.leap.Controller;
import com.leapmotion.leap.Finger;
import com.leapmotion.leap.Frame;
import com.leapmotion.leap.Hand;
import com.leapmotion.leap.Tool;
import com.leapmotion.leap.Vector;
import com.leapmotion.leap.processing.LeapMotion;

LeapMotion leapMotion;

ConcurrentMap<Integer, Vector> fingerPositions;

PFont font;
Player player;
ArrayList<Villain> villains;
Cursor cursor;

int lastTimer = 0;
long t = 0;
PImage gameFloor;
int score = 0;

void setup() {
    size(500, 500);
    imageMode(CENTER);
    noCursor();

    leapMotion = new LeapMotion(this);
    fingerPositions = new ConcurrentHashMap<Integer, Vector>();

    cursor = new Cursor(true);
    player = new Player(250, 250, cursor);
    villains = new ArrayList<Villain>();

    t = millis();
    gameFloor = loadImage("g_bg.png");
    font = loadFont("Simonetta-Regular-48.vlw");
    textFont(font, 24);
}

void draw() {
    image(gameFloor, 250, 250);
    int timer = int((millis() - t) / 1000);
    if (player.life < 3) {
      fill(250, 0, 25);
    } else {
      fill(255);
    }
    text("Life: " + player.life, 10, 24);
    fill(255);
    text("Dodged fireballs: " + score, 10, 50);

    if ( lastTimer < timer ) {
        villains.add( new Villain() );
    }

    player.shift();
    if ( player.isHit ) {
        player.hit();
    }

    for (Iterator<Villain> iterator = villains.iterator(); iterator.hasNext(); ) {
        Villain villain = iterator.next();

        villain.move();

        if ( villain.isDead ) {
            iterator.remove();
        } else if ( villain.isDying ) {
            villain.die();
            villain.draw();
        } else if ( ballBall(int(villain.posx), int(villain.posy), 20, int(player.posx), int(player.posy), 70) ) {
            float v = villain.getDegree();
            float p = player.getDegree();
            float distance = abs(v - p);
            if ( distance <= 45 || distance >= 315 ) {
                println("We did not loose a life");
                score += 1;
            } else {
                println("We lost a life");
                player.life -= 1;
                player.newHit();
                player.hit();
            }
            villain.die();
            villain.draw();
        } else   {
            villain.draw();
        }
    }

    if (player.life == 0) {
      noLoop();
      background(0);
      textAlign(CENTER);
      textFont(font, 48);
      fill(250, 0, 25);
      text("GAME OVER!", width/2, height/2);
      return;
    }

    player.draw();
    cursor.draw();

    lastTimer = timer;
}

boolean ballBall(int x1, int y1, int d1, int x2, int y2, int d2) {

  // find distance between the two objects
  float xDist = x1-x2;                                   // distance horiz
  float yDist = y1-y2;                                   // distance vert
  float distance = sqrt((xDist*xDist) + (yDist*yDist));  // diagonal distance

  // test for collision
  if (d1/2 + d2/2 > distance) {
    return true;    // if a hit, return true
  }
  else {            // if not, return false
    return false;
  }
}

void onFrame(final Controller controller)
{
    if ( cursor.leap ) {
        cursor.onFrame(controller);
    }
}
