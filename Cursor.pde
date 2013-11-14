class Cursor {

    boolean leap;
    float posx, posy;

    Cursor(boolean leap) {
        this.leap = leap;
        posx = 0;
        posy = 0;
    }

    float getX() {
        return leap ? posx : mouseX;
    }

    float getY() {
        return leap ? posy : mouseY;
    }

    void draw() {
        fill(100,200,100,100);
        noStroke();
        ellipse(posx, posy, 24.0, 24.0);
    }

    void onFrame(final Controller controller)
    {
        //println("hmm");
        Frame frame = controller.frame();
        fingerPositions.clear();
        Finger finger = frame.fingers().get(0);
        int fingerId = finger.id();
        println(fingerId);
        Vector position = finger.tipPosition();
        posx = leapMotion.leapToSketchX(position.getX());
        posy = leapMotion.leapToSketchY(position.getY());
        // ellipse(leapMotion.leapToSketchX(position.getX()), leapMotion.leapToSketchY(position.getY()), 24.0, 24.0);
        /*for (Finger finger : frame.fingers())
        {
            int fingerId = finger.id();
            println(fingerId);
            color c = color(random(0, 255), random(0, 255), random(0, 255));
            fingerColors.putIfAbsent(fingerId, c);
            fingerPositions.put(fingerId, finger.tipPosition());
        }*/
    }
}
