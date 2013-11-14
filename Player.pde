class Player {

    float posx, posy;
    float direction; // in degrees
    float diameter;
    int life;
    PImage player = loadImage("g_player.png");
    PImage playerHit = loadImage("g_player_hit.png");
    Player(float posx, float posy) {
        this.posx = posx;
        this.posy = posy;
        direction = 90;
        diameter = 30;
        life = 5;
    }

    void draw() {
        ellipse(posx, posy, diameter, diameter);
        line(posx, posy, posx + cos(radians(direction))*(diameter/2), posy - sin(radians(direction))*(diameter/2));
        translate(width/2, height/2);
        rotate(radians(-getDegree()));
        image(player, -player.width / 2, -player.height / 2);
    }

    float getDegree() {
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
        //println( degree );
        return degree;
    }

    void shift() {
        direction = getDegree();
    }

}
