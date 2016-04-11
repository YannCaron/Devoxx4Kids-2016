// Space battle by CyaNn
include("lib/global");

// initialize -------------------------------------------------------
game.setDebug(false);

set stage = game.createStage(0, 0);
set layer = stage.createLayer();
layer.createRepeatedImage("PlanetCute/Sky");

layer.createActor("PlanetCute/planet", 250, 250).typeKinematic();

set vl = layer.createVerticalLayout(stage.getWidth() / 2, stage.getHeight() / 2);

vl.addActor (
layer.createButton(font, "orange", "Space battle")
.onTap( {load("SpaceBattle")} )
)

vl.addActor (
layer.createButton(font, "orange", "Jumper")
.onTap( {load("Jumper")} )
)

vl.addActor (
layer.createButton(font, "orange", "Angry turtle")
.onTap( {load("AngryTurtle")} )
)

vl.addActor (
layer.createButton(font, "orange", "Platform")
.onTap( {load("Platform")} )
)


vl.addActor (
layer.createButton(font, "orange", "CuteJet - MixTeen 2015")
.onTap( {load("CuteJet.byCyaNn")} )
)

//layer.createCheckBox(font, "check", "check this", 150, 150);

// add this to activate scene transition animation
game.goNext();

