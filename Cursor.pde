class Cursor {

    boolean leap;
    boolean fingerPanic;
    float posx, posy;

    Cursor(boolean leap) {
        this.leap = leap;
        fingerPanic = !leap;
        posx = 100;
        posy = 100;
    }

    float getX() {
        return leap ? posx : mouseX;
    }

    float getY() {
        return leap ? posy : mouseY;
    }

    void draw() {
        fill(100,200,100,100);
        if ( fingerPanic ) {
            fill(200,100,100,100);
        }
        noStroke();
        ellipse(posx, posy, 24.0, 24.0);
    }

    void onFrame(final Controller controller)
    {
        boolean foundFinger = false;
        Finger finger = null;

        Frame frame = controller.frame();

        for (Finger f : frame.fingers())
        {
            if ( !foundFinger && f.id() != -1 ) {
                foundFinger = true;
                finger = f;
            }
        }

        if ( finger != null ) {
            Vector position = finger.tipPosition();
            posx = leapMotion.leapToSketchX(position.getX());
            posy = leapMotion.leapToSketchY(position.getY());
            fingerPanic = false;
        } else {
            println("FINGER PANIC!!!");
            fingerPanic = true;
        }
    }
}
