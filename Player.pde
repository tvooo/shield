class Player {

    float posx, posy;
    float direction; // in degrees
    float diameter;
    int life;
    Cursor cur;

    Player(float posx, float posy, Cursor cur) {
        this.posx = posx;
        this.posy = posy;
        this.cur = cur;
        direction = 90;
        diameter = 40;
        life = 5;
    }

    void draw() {
        fill(255);
        stroke(0);
        strokeWeight(2);
        ellipse(posx, posy, diameter, diameter);
        line(posx, posy, posx + cos(radians(direction))*(diameter/2), posy - sin(radians(direction))*(diameter/2));
    }

    float getDegree() {
        float degree = 90;
        float len = dist(posx, posy, cur.getX(), cur.getY());

        float y = degrees(asin((posy-cur.getY()) / len));
        float x = degrees(acos((posx-cur.getX()) / len));
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

    void shift() {
        direction = getDegree();
    }

}
