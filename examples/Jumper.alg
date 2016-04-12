// Jumper by CyaNn & ALGEA
include("lib/global");
include("lib/debugLayer");
"lgoid/Turtle"
// variables
set stage = game.createStage(0, -10);
set gameLayer = stage.createLayer();
set scoreLayer = stage.createLayer();

buildDebugLayer(stage);

// background
set bg = gameLayer.createRepeatedImage("PlanetCute/Sky");

// create ground
for (set i = 1; i * 101 < stage.getWidth(); i++) {
	set grass = gameLayer.createActor("PlanetCute/Grass Block", i * 101, 50);
	grass.typeStatic().hitSquare(75);
}

// virtual ground
set ground = gameLayer.createWall(stage.getWidth() / 2, 0, 100, 10).typeStatic().hitSquare();

// create player
set player = gameLayer.createActor("PlanetCute/Character Princess Girl", stage.getWidth() / 2, 200);
player.typeDynamic().hitCircle().fixeRotation().setRestitution(0);
gameLayer.follow(player);

// clouds
set createCloud = function (y, isAnimated) {
	set c = math.random(3) + 1;
	set x = 150 + math.random(stage.getWidth() - 300);
	set cloud = gameLayer.createActor("Platformer/Cloud" .. c, x, y);
	cloud.typeSensor().hitSquare();

	// animate
	if (isAnimated) {
		stage.createTween(cloud.getX, cloud.setX, 2, x + 100).repeatYoyo().start();
	}

}

for (set i = 1; i < 200; i++) {
	createCloud (i * 250, (i % 3 == 0));
}

set jump = false;

stage.onTouch((x, y) {
	jump = true;
	player.setXVelocity(-(player.getX() - x) / 100);
});

// can lose
set maxY = 0;
set gameOver = false;

gameLayer.onScroll((x, y) {
	ground.setX(player.getX());
	if (y > maxY) {
		ground.setY(y);
		maxY = y;
	}
});

ground.onContactWith(player, {
	gameOver = true;
	gameLayer.remove(ground);
	player.setSensor(true).rotate(180).setYVelocity(10).outRemove();
});

stage.onUp({ jump = false; });

set cloud = gameLayer.createActor("Platformer/Cloud1", 550, 250);
cloud.typeSensor().hitSquare();
stage.createSequence()
	.add(stage.createTween(cloud.getX, cloud.setX, 1, cloud.getX() + 100))
	.add(stage.createTween(cloud.getY, cloud.setY, 1, cloud.getY() + 100))
	.repeatYoyo().start();

player.onPulse({
	if (gameOver) return 0; // avoid event

	if (jump && player.isContacting() && player.getYVelocity() <= 0) {
		player.setYVelocity(0);
		player.impulse(0, 12);
	}
});

// add this to activate scene transition animation
game.goNext();
