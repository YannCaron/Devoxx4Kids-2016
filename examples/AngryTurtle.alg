// Angry turtle by CyaNn & ALGEA
include("lib/global");
include("lib/debugLayer");
false

set stage = game.createStage(0, -9.8);
set backLayer = stage.createLayer();
set gameLayer = stage.createLayer();

backLayer.createRepeatedImage("PlanetCute/Sky");

buildDebugLayer(stage);

set addFloorElement = function (stage, name, x, y) {
	gameLayer.createActor("PlanetCute/" .. name .. "", 150, 150)
		.move(x, y)
		.hitSquare(85)
		.setFriction(0.5);
};

set addBlockElement = function (stage, name, x, y) {
	gameLayer.createActor("PlanetCute/" .. name .. "")
		.move(x, y)
		.typeDynamic()
		.hitSquare(50, 35, 0, 0)
		.setMass(1)
		.setFriction(0.2)
		.bullet();
};

set addHBlockElement = function (stage, name, x, y) {
	set actor = gameLayer.createActor("PlanetCute/" .. name .. "")
		.move(x, y)
		.typeDynamic()
		.hitSquare(10, 0, 0, 0)
		.rotate(90)
		.setMass(1)
		.setFriction(0.2)
		.bullet();

	actor.setHeight(actor.getHeight() * 1.5)

};

set addOther = function (stage, name, x, y) {
	set actor = gameLayer.createActor("PlanetCute/" .. name .. "")
		.move(x, y)
		.typeDynamic()
		.hitCircle()
		.setRestitution(0.5);

	return actor;
};

for (set i = 0; i < 5; i++) {
	addFloorElement(stage, "Grass Block", 50 + 100 * i, 85);
}

for (set i = 0; i < 40; i++) {
	addFloorElement(stage, "Dirt Block", 550 + 100 * i, 85);
}

for (set i = 0; i < 3; i++) {
	addBlockElement(stage, "Wall Block Tall", 750, 250 + 88 * i);
	addBlockElement(stage, "Wall Block Tall", 950, 250 + 88 * i);
}

addHBlockElement(stage, "Wall Block Tall", 850, 255 + 88 * 3);

set other = addOther(stage, "Character Princess Girl", 850, 255 + 88 * 3 + 100);

set player = gameLayer.createActor("Algoid/Icon").move(150, 450)
	.typeDynamic().hitCircle().setRestitution(0.5).setSleepingAllowed(false);

gameLayer.follow(player);

// sound
set lazer1 = game.createSound("Futur/Lazer1");

set origX = 0;
set origY = 0;
/*
gameLayer.onScroll((x, y) {
	backLayer.scroll(x * 0.5, y * 0.5);
});*/

stage.onTap((x, y) {
	origX = x;
	origY = y;
});

stage.onTouch((x, y) {
	player.move(x, y).keep();
});

stage.onUp((x, y) {
	player.release();
	set impulseX = (origX - x) * 0.07;
	set impulseY = (origY - y) * 0.07;
	print(impulseX);
	player.impulse(impulseX, impulseY);
	lazer1.play();
});

// add this to activate scene transition animation
game.goNext();
