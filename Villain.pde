class Villain {

    float posx, posy;
    int life;
    boolean isDying, isDead;
    PImage villain = loadImage("g_villain.png");
    PImage villain_hit = loadImage("g_villain_hit.png");

    Villain() {
        float topOrBottom = int(random(2)),
              positive = int(random(2));
        life = 10;
        isDead = false;
        isDying = false;

        if ( topOrBottom == 1 ) {
            posx = random(width);
            if ( positive == 1 ) {
                posy = height + random(100);
            } else {
                posy = -random(100);
            }
        } else {
            posy = random(height);
            if ( positive == 1 ) {
                posx = width + random(100);
            } else {
                posx = -random(100);
            }
        }


    }

    void die() {
        life--;
        isDying = true;
        if ( life == 0 ) {
            isDead = true;
        }
    }

    void draw() {
        pushMatrix();
        translate(posx,posy);
        rotate(radians(-getDegree() + 90));
        image(isDying ? villain_hit : villain, 0, -27);
        popMatrix();
    }

    void move() {
        if ( isDying ) {
            return;
        }
        float playerx = width / 2;
        float playery = width / 2;
        float len = dist(posx, posy, width / 2, height / 2);
        posx = posx + (playerx - posx) / len;
        posy = posy + (playery - posy) / len;
    }

    float getDegree() {
        float degree = 90;
        float playerx = width / 2;
        float playery = width / 2;
        float len = dist(playerx, playery, posx, posy);

        float y = degrees(asin((playery-posy) / len));
        float x = degrees(acos((playerx-posx) / len));
        //println(x + "/" + y);
        if ( x < 90 && x >= 0 && y >= 0 ) {
            degree = 180 - x;
        } else if ( x > 90 && y >= 0) {
            degree = y;
        } else if ( y < 0) {
            degree = 180 + x;
        }
        //println( degree );
        return degree;
    }
}
