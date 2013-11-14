class Villain {

    float posx, posy;

    Villain() {
        float topOrBottom = int(random(2)),
              positive = int(random(2));

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

    void draw() {
        ellipse(posx, posy, 20, 20);
    }

    void move() {
        float playerx = width / 2;
        float playery = width / 2;
        float len = dist(posx, posy, width / 2, height / 2);
        posx = posx + (playerx - posx) / len;
        posy = posy + (playery - posy) / len;
    }
}
