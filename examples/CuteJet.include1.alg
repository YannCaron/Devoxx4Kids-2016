// CuteJet by CyaNn & ALGEA

// score
set score;
set scoreLabel = scoreLayer.createLabel(font, score, 10, stage.getHeight() - 25);
score.onChanged( {scoreLabel.setText("score:: " .. score); } );
score = 0;

// button
scoreLayer
	.createButton(font, "black", "debug", stage.getWidth() - 115, stage.getHeight() - 70)
	.onTap ({ game.setDebug(!game.getDebug()); });

// life
set life;
set lifeLabel = scoreLayer.createLabel(font, score, 150, stage.getHeight() - 25);
life.onChanged ( {lifeLabel.setText("life:: " .. life); } );
life = 5;

// gameover
set gameOver = function (rock, actor) {
	life--;
	if (life == 0) {
		set font = game.createFont("emulogic", 25, game.color.RED);
		set over = game.createStage(0, 0);
		set layer = over.createLayer();

		layer.createRepeatedImage("PlanetCute/Sky");
		layer.createActor("PlanetCute/planet", 300, 250);
		layer.createLabel(font, "Game Over", over.getWidth() / 2 - 75, over.getHeight() / 2);
		game.goNext();

		set sound = game.createSound("Game/Explode1").play();

	} else {
		gameLayer.remove(rock);

		set sound = game.createSound("Game/Explode1").play();

		actor.onPulse({
			actor.setAlpha(if (actor.getAlpha() == 1) 0.2 else 1)
		}, 20, 20);

	}
};

set gameWin = function (wall, actor) {
	set font = game.createFont("emulogic", 25, game.color.WHITE);
	set over = game.createStage(0, 0);
	set layer = over.createLayer();

	layer.createRepeatedImage("PlanetCute/Sky");
	layer.createActor("PlanetCute/planet", 300, 250);
	layer.createLabel(font, "You win", over.getWidth() / 2 - 75, over.getHeight() / 2);
	game.goNext();

	set sound = game.createSound("Game/Win1").play();
};
// background
gameLayer.createRepeatedImage("PlanetCute/Sky");
