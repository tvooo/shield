class Player {

    float posx, posy;
    float direction; // in degrees
    float diameter;
    int life;
    PImage player = loadImage("g_player.png");
    PImage playerHit = loadImage("g_player_hit.png");
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
        pushMatrix();
        translate(width/2, height/2);
        rotate(radians(-getDegree()));
        image(player, 0, 0, player.width, player.height);
        popMatrix();
        fill(255);
        ellipse(posx, posy, diameter, diameter);
    }

    float getDegree() {
        float degree = 90;
        float len = dist(posx, posy, cur.getX(), cur.getY());

        float y = degrees(asin((posy-cur.getY()) / len));
        float x = degrees(acos((posx-cur.getX()) / len));
        if ( x < 90 && x >= 0 && y >= 0 ) {
            degree = 180 - x;
        } else if ( x > 90 && y >= 0) {
            degree = y;
        } else if ( y < 0) {
            degree = 180 + x;
        }
        return degree;
    }

    void shift() {
        direction = getDegree();
    }

}
