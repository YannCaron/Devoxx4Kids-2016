// -----------------------------------------------------------------------------
// CuteJet by CyaNn & ALGEA
// NE PAS MODIFIER CETTE PARTIE DU CODE

// variables
set font = game.createFont("emulogic", 12, game.color.WHITE);

// stage
set stage = game.createStage(0, -10);
set gameLayer = stage.createLayer();
set scoreLayer = stage.createLayer();

include("CuteJet.include1");

// On commence à partir d'ici **
// A NOUS DE JOUER
// -----------------------------------------------------------------------------
set enemyUFO = gameLayer.createActor("SpaceArt/enemyUFO", 250, 250);
enemyUFO.typeDynamic().hitCircle().setRestitution(0.95);

stage.onTap(() { 
	enemyUFO.impulseY(10) 
	enemyUFO.say(font, "Hi !")
});



// -----------------------------------------------------------------------------
// NE PAS MODIFIER LA PARTIE SUIVANTE DU CODE

include("CuteJet.include2");
