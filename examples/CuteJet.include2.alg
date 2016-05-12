// CuteJet by CyaNn & ALGEA

if (exists(hero)) {
	hero.fixeRotation();
	hero.setMaxVelocity(20);
	gameLayer.follow(hero);
}

gameLayer.createWall(gameLayer.getWidth() / 2, stage.getHeight() - 2, gameLayer.getWidth(), 4).typeStatic().hitSquare();
gameLayer.createWall(gameLayer.getWidth() / 2, 2, gameLayer.getWidth(), 4).typeStatic().hitSquare();
gameLayer.createWall(2, stage.getHeight() / 2, 4, stage.getHeight()).typeStatic().hitSquare();

set wall = gameLayer.createWall(gameLayer.getWidth() + 5, stage.getHeight() / 2, 4, stage.getHeight()).typeStatic().hitSquare();
wall.onContact( (wall, other) {
	if (other == hero) {
		gameWin();
	}
});
