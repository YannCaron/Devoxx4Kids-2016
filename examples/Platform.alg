// Platform by CyaNn & ALGEA
include("lib/global");
include("lib/debugLayer");

// variables
set stage = game.createStage(0, -10);
set backLayer = stage.createLayer();
set gameLayer = stage.createLayer();
set scoreLayer = stage.createLayer();
set direction = 1;
set jumping = false;

buildDebugLayer(stage);

// background
set bg = backLayer.createRepeatedImage("PlanetCute/Sky");

// initialize
set player = gameLayer.createActor("PlanetCute/Character Princess Girl", 150, 100);

// functions
set createCloud = function (x, y, dx, dy) {
	set cloud = gameLayer.createActor("Platformer/Cloud1", x, y)
		.typeKinematic().hitSquare(30, 0, 10, 10);

	stage.createTween(
		array{cloud.getX, cloud.getY}, cloud.move, 2, array{x + dx, y + dy}
	).repeatYoyo().start();
	
	cloud.onContactWith(player, () {
		if (player.isContactingBottom() && !jumping)
			player.applyForceY(-100);
	})
}

// create ground
for (set i = 0; i < 25; i++) {
	set block = if (i < 7) "Grass Block" else "Stone Block";
	gameLayer.createActor("PlanetCute/" .. block, i * 100, 50).hitSquare(75);
}

// create items
gameLayer.createActor("PlanetCute/Wall Block Tall", 0, 125).hitSquare();
gameLayer.createActor("PlanetCute/Wall Block Tall", 24 * 100, 125).hitSquare();
gameLayer.createActor("PlanetCute/Tree Short", 450, 85).hitSquare(10, 0, 20, 20);

createCloud(570, 230, 0, 100);

// player
player.typeDynamic().hitCircle().bullet().fixeRotation().setMaxVelocity(5).setFriction(0).raiseOnTop();

gameLayer.follow(player);

stage.onKey((ch) {
	if (ch == game.key.LEFT) {
		player.setFriction(0).impulseX(-0.1).applyForceX(-50);
		direction = -1;
	} else if (ch == game.key.RIGHT) {
		player.setFriction(0).impulseX(0.1).applyForceX(50);
		direction = 1;
	} else if (ch == game.key.UP) {
		if (!jumping) player.applyForceY(0).impulse(0, 11);
		jumping = true;
	} else if (ch == game.key.SPACE) {
		set star = gameLayer.createActor("PlanetCute/Little Star", player.getX() + 85 * direction , player.getY())
			.typeDynamic().hitCircle()
			.impulse(4 * direction, -2).setRestitution(1).outRemove().setFriction(0).setGravityScale(4);

		star.onContact(() {
			if (star.isContactingLeft() || star.isContactingRight()) {
				gameLayer.remove(star);
			}
		})

	}
});

player.onContact(() {
	jumping = false;
});

stage.onKeyUp((ch) {
	if (ch == game.key.LEFT) {
		player.setFriction(25).applyForce(0, 0);
	} else if (ch == game.key.RIGHT) {
		player.setFriction(25).applyForce(0, 0);
	}
})

gameLayer.onScroll((x, y) {
	backLayer.scroll(x * 0.1, y * 0.1);
});

// add this to activate scene transition animation
game.goNext();
