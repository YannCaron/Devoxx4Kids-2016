// Space battle by CyaNn & ALGEA
include("lib/global");
include("lib/debugLayer");

// variables
set fire = false;

set stage = game.createStage(0, 0);
set gameLayer = stage.createLayer();
set scoreLayer = stage.createLayer();

buildDebugLayer(stage);

// enemies
set enemyNum = 1;
set enemies = array {};
set score;
set life;

// sound
set lazerSound1 = game.createSound("Futur/Lazer1");
set lazerSound2 = game.createSound("Futur/Lazer2");

// background
set bg = gameLayer.createRepeatedImage("SpaceArt/starBackground");

// player
set player = gameLayer.createActor("SpaceArt/player", stage.getWidth() / 2, 200);
player.typeDynamic().hitSquare().fixeRotation();

// score
set scoreLabel = scoreLayer.createLabel(font, "Score", 20, stage.getHeight() - 20);
score.onChanged((v) { scoreLabel.setText("Score: " .. v) }) // now all AL variables have event when value is changed
score = 0; // raise event

// life
set lifeLabel = scoreLayer.createLabel(font, "Life", 170, stage.getHeight() - 20);
life.onChanged((v) { lifeLabel.setText("Life: " .. v) }) // now all AL variables have event when value is changed
life = 5; // raise event

// touchpad
set pad = scoreLayer.createPad("white", 25, 25);
set aButton = scoreLayer.createButtonImage("white.a", stage.getWidth() - 200, 100);

// create wall
set createWall = function (x, y, w, h) {
	set wall = gameLayer.createWall(x, y, w, h).typeStatic().hitSquare();
}

// walls
createWall(0, stage.getHeight() / 2, 20, stage.getHeight()); // left
createWall(stage.getWidth(), stage.getHeight() / 2, 20, stage.getHeight()); // right

createWall(stage.getWidth() / 2, stage.getHeight(), stage.getWidth(), 20); // top
createWall(stage.getWidth() / 2, 300, stage.getWidth(), 20); // bottom

// declaring  -------------------------------------------------------
// function
// when player fire
set playerFire = function () {
	// create lazer
	set lazer = gameLayer.createActor("SpaceArt/laserRed", player.getX(), player.getY() + 45);
	lazer.hitSquare().typeSensor().outRemove();
	lazer.setYVelocity(25);

	lazerSound1.play(0.5, 2);

	lazer.onContactWith(enemies, (lazer, enemy, x, y) {

		// remove from list
		enemies.remove(enemy);

		// remove from stage
		gameLayer.remove(enemy);
		gameLayer.remove(lazer);

		// particle
		gameLayer.createParticle("laserRedShot", x, y);

		// score
		score += 10; // variable event will do the stuff

		// create new if no more
		if (enemies.length() == 0) createEnemies(); // next level
	});
};

// when enemy fire
set enemyFire = function (enemy) {
	// create lazer
	set lazer = gameLayer.createActor("SpaceArt/laserGreen", enemy.getX(), enemy.getY() - 25);
	lazer.hitSquare().typeSensor().outRemove();

	// aim the player
	set toX = enemy.getX() - player.getX();
	set toY = enemy.getY() - player.getY();
	lazer.rotate(math.aim(toX, toY));

	lazer.setVelocity(-toX / 100, -toY / 100);

	lazerSound2.play(1); // play with low volume

	lazer.onContactWith(player, (lazer, player, x, y) {
		// remove from stage
		gameLayer.remove(lazer);
		// particle
		gameLayer.createParticle("laserGreenShot", x, y);
		// score
		life--; // variable event will do the stuff
	});
};

// create enemies
set createEnemies = function () {

	loop (enemyNum) {
		// create enemy
		set x = math.random(stage.getWidth());
		set y = stage.getHeight() * 0.5 + math.random(100);

		set enemy = gameLayer.createActor("SpaceArt/enemyShip", x, y);
		enemy.hitSquare().typeDynamic().fixeRotation();

		enemy.setVelocity (math.random(10) - 5, math.random(10) - 5);

		// enemy behaviour
		enemy.onPulse({
			enemy.setVelocity (math.random(10) - 5, math.random(10) - 5);
		}, 1500);

		enemy.onPulse({
			enemyFire(enemy);
		}, 500 + math.random(500));

		// add it to list (for contact with event and know number)
		enemies.add(enemy);
	}

	enemyNum++;
};


// program start ----------------------------------------------------

// enemies
createEnemies();

// event
player.onPulse({ if (fire) playerFire() }, 150);

pad.onTouchPulse((x, y) {
	set px = player.getX() + 50 * x;
	player.setX (px);
});

aButton.onTouchPulse({ playerFire(); }, 150);

player.onTap({ fire = true; })
player.onUp({ fire = false; })

stage.onTouch((x, y) {
	player.setX(x);
});

stage.onKey ( (k) {
	if (k == "n") {
		if (game.hasNext()) {
			game.goNext();
		} else {
			createMenu();
		}
	} else if (k == "b") {
		game.goBack();
	}
} );

// add this to activate scene transition animation
game.goNext();

