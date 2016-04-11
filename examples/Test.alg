// Space battle by CyaNn
include("lib/global");
include("lib/debugLayer");

// initialize -------------------------------------------------------
game.setDebug(true);

set stage = game.createStage(0, -10);
set layer = stage.createLayer();
layer.createRepeatedImage("PlanetCute/Sky");

layer.createWall(512, 2, 1024, 4).typeStatic().hitSquare();

set actor = layer
    .createActor("PlanetCute/Character Horn Girl", 250, 550)
    .typeDynamic().hitCircle()
    .setRestitution(1);

stage.onTouch((x, y) {
	actor.move(x, y);
	actor.keep();
});

stage.onUp(() {
actor.release();
});
