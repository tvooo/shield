Player player;

void setup() {
    size(500, 500);
    player = new Player(250, 250);
}

void draw() {
    background(100);
    player.shift();
    player.draw();

}
