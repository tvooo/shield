import java.util.Iterator;

Player player;
ArrayList<Villain> villains;

int lastTimer = 0;
long t = 0;
PImage gameFloor;
int score = 0;

void setup() {
    size(500, 500);
    player = new Player(250, 250);
    villains = new ArrayList<Villain>();
    t = millis();
    gameFloor = loadImage("g_bg.png");
}

void draw() {
    image(gameFloor, 0, 0);
    int timer = int((millis() - t) / 1000);
    
    text("Life: " + player.life, 40, 40);
    text("Dodged fireballs: " + score, 40, 60);
    
    if ( lastTimer < timer ) {
        villains.add( new Villain() );
    }

    player.shift();

    for (Iterator<Villain> iterator = villains.iterator(); iterator.hasNext(); ) {
        Villain villain = iterator.next();

        villain.move();

        if ( villain.isDead ) {
            iterator.remove();
        } else if ( villain.isDying ) {
            villain.die();
            villain.draw();
        } else if ( ballBall(int(villain.posx), int(villain.posy), 20, int(player.posx), int(player.posy), 40) ) {
            float v = villain.getDegree();
            float p = player.getDegree();
            /*if ( abs( v - p ) < 20 ) {

            }*/
            float distance = abs(v - p);
            if ( distance <= 30 || distance >= 330 ) {
                println("We did not loose a life");
                score += 1;
            } else {
                println("We lost a life");
                player.life -= 1;
            }
            villain.die();
            villain.draw();
        } else   {
            villain.draw();
        }
    }
    
    if (player.life == 0) {
      noLoop();
      textAlign(CENTER);
      text("GAME OVER!", width/2, height/2);
    }


    player.draw();

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
