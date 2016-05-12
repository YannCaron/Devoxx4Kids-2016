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

// le héro
set hero = gameLayer.createActor("PlanetCute/beetleship");
hero.move(200,400);

// le décor
set x =0;
loop(50)
{
	set ground = gameLayer.createActor("PlanetCute/Grass Block");
	ground.move(x,50);
	x = x + ground.getWidth();
	
	ground.typeStatic().hitSquare(75);
}

// physique
hero.typeDynamic().hitCircle(15);

// avance
hero.applyForceX(15);

// quand on clique, saute
stage.onTap(() {
	hero.impulseY(15);
});

// -----------------------------------------------------------------------------
// NE PAS MODIFIER LA PARTIE SUIVANTE DU CODE

include("CuteJet.include2");
