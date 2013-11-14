import java.util.Iterator;

Player player;
ArrayList<Villain> villains;

int lastTimer = 0;
long t = 0;

void setup() {
    size(500, 500);
    player = new Player(250, 250);
    villains = new ArrayList<Villain>();
    t = millis();
}

void draw() {
    int timer = int((millis() - t) / 1000);

    if ( lastTimer < timer ) {
        villains.add( new Villain() );
    }

    background(100);
    player.shift();

    for (Iterator<Villain> iterator = villains.iterator(); iterator.hasNext(); ) {
        Villain villain = iterator.next();

        villain.move();
        if ( ballBall(int(villain.posx), int(villain.posy), 20, int(player.posx), int(player.posy), 40) ) {
            iterator.remove();
        } else {
            villain.draw();
        }
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
