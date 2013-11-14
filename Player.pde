class Player {

    float posx, posy;
    float direction; // in degrees
    float diameter;

    Player(float posx, float posy) {
        this.posx = posx;
        this.posy = posy;
        direction = 90;
        diameter = 40;
    }

    void draw() {
        ellipse(posx, posy, diameter, diameter);
        line(posx, posy, posx + cos(radians(direction))*(diameter/2), posy - sin(radians(direction))*(diameter/2));
    }

    void shift() {
        float degree = 90;
        float len = dist(posx, posy, mouseX, mouseY);

        float y = degrees(asin((posy-mouseY) / len));
        float x = degrees(acos((posx-mouseX) / len));
        //println(x + "/" + y);
        if ( x < 90 && x >= 0 && y >= 0 ) {
            degree = 180 - x;
        } else if ( x > 90 && y >= 0) {
            degree = y;
        } else if ( y < 0) {
            degree = 180 + x;
        }
        println( degree );
        direction = degree;
    }

}
