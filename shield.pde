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

ConcurrentMap<Integer, Integer> fingerColors;
ConcurrentMap<Integer, Integer> toolColors;
ConcurrentMap<Integer, Vector> fingerPositions;
ConcurrentMap<Integer, Vector> toolPositions;

Player player;
ArrayList<Villain> villains;
Cursor cursor;

int lastTimer = 0;
long t = 0;

void setup() {
    size(500, 500);
    noCursor();

    leapMotion = new LeapMotion(this);
    fingerColors = new ConcurrentHashMap<Integer, Integer>();
    toolColors = new ConcurrentHashMap<Integer, Integer>();
    fingerPositions = new ConcurrentHashMap<Integer, Vector>();
    toolPositions = new ConcurrentHashMap<Integer, Vector>();

    cursor = new Cursor(true);
    player = new Player(250, 250, cursor);
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
            } else {
                println("We lost a life");
            }
            villain.die();
            villain.draw();
        } else   {
            villain.draw();
        }
    }

    player.draw();
    cursor.draw();



    /*for (Map.Entry entry : fingerPositions.entrySet())
    {
        Integer fingerId = (Integer) entry.getKey();
        Vector position = (Vector) entry.getValue();
        fill(fingerColors.get(fingerId));
        noStroke();
        ellipse(leapMotion.leapToSketchX(position.getX()), leapMotion.leapToSketchY(position.getY()), 24.0, 24.0);
    }*/

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
  /*Frame frame = controller.frame();
  fingerPositions.clear();
  for (Finger finger : frame.fingers())
  {
    int fingerId = finger.id();
    color c = color(random(0, 255), random(0, 255), random(0, 255));
    fingerColors.putIfAbsent(fingerId, c);
    fingerPositions.put(fingerId, finger.tipPosition());
  }
  toolPositions.clear();
  for (Tool tool : frame.tools())
  {
    int toolId = tool.id();
    color c = color(random(0, 255), random(0, 255), random(0, 255));
    toolColors.putIfAbsent(toolId, c);
    toolPositions.put(toolId, tool.tipPosition());
  }*/
}
