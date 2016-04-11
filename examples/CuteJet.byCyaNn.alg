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

set music = game.createSound("Loop/Vibraphone")
music.playLoop();

set hero = gameLayer.createActor("PlanetCute/beetleship");
hero.move(200, 700);
hero.typeDynamic().hitCircle(15);

// floor
set x = 0;
set i = 0;
set grounds = array {"Grass Block", "Dirt Block", "Brown Block"};
loop(200) {
	if (math.random(5) == 0) {
		i = math.random(grounds.length());
	}
	
	set ground = gameLayer.createActor("PlanetCute/" .. grounds[i]);
	ground.move(x, 50);
	ground.typeStatic().hitSquare(75);
	x = x + ground.getWidth();
}

// trees
set trees = array {"Tree Short", "Tree Tall", "Tree Ugly"};
loop(25) {
	set x = math.random(gameLayer.getWidth());
	set i = math.random(trees.length());
	
	set tree = gameLayer.createActor("PlanetCute/" .. trees[i]);
	tree.move(x, 100);
	tree.typeStatic().hitSquare();
}

// enemies
loop (25) {
	set x = math.random(gameLayer.getWidth());
	
	set enemy = gameLayer.createActor("PlanetCute/Enemy Bug");
	set enemy.force = 15;
	enemy.move(x, 100);
	enemy.typeDynamic().hitSquare();
	enemy.fixeRotation();
	
	enemy.applyForceX(enemy.force);
	
	set contact = function (enemy, other) {
		if (other.getName() == "PlanetCute/Star") {
			gameLayer.remove(enemy);
			score = score + 15;
			game.createSound("Game/Toc1").play();
		}elseif (!other.getName().contains("Block")) {
			enemy.force = -enemy.force;
			enemy.applyForceX(enemy.force);
			enemy.flipX();
		}
	}
	
	enemy.onContact(contact);
	
}

// bonus
set gems = array {"Gem Blue", "Gem Green", "Gem Orange"};
loop(25) {
	set x = math.random(gameLayer.getWidth());
	set y = math.random(stage.getHeight() - 50);
	set g = math.random(gems.length());
	
	set gem = gameLayer.createActor("PlanetCute/" .. gems[g]);
	gem.typeSensor().hitCircle();
	gem.move(x, y);
	gem.scale(0.5);
	
	set winGem = function () {
		score = score + 10;
		gameLayer.remove(gem);
		game.createSound("Game/Ring2").play();
	};
	
	gem.onContactWith(hero, winGem);
}

// dangers
set throwRock = function () {
	set y = math.random(stage.getHeight());
	set rock = gameLayer.createActor("PlanetCute/Rock");
	rock.move(hero.getX() + 750, stage.getHeight() - 50);
	rock.typeSensor().hitCircle();
	rock.setYVelocity(-7);
	
	set contact = function (rock, other) {
		if (other.getName() == "PlanetCute/Star") {
			gameLayer.remove(rock);
			score = score + 10;
			game.createSound("Game/Toc1").play();
		}
	}
	
	rock.onContact(contact);
	rock.onContactWith(hero, gameOver);
}
hero.onPulse(throwRock, 1500);

// le hero avance
hero.applyForceX(25);

// on limite sa vitesse
hero.setMaxVelocity(10);

// mais ne tourne pas
hero.fixeRotation();

// et la caméra le suit
gameLayer.follow(hero);

// jump
set jump = function() {
	if (hero.getY() < stage.getHeight() - 200) {
		hero.impulseY(15);
	}
}
stage.onTap(jump);

// shoot
set shoot = function () {
	set shoot = gameLayer.createActor("PlanetCute/Star");
	shoot.move(hero.getX() , hero.getY() - hero.getHeight() / 2);
	shoot.typeDynamic().hitCircle();
	shoot.scale(0.5);
	shoot.setXVelocity(hero.getXVelocity());
	shoot.setYVelocity(-10);
	
	shoot.onContact((shoot) { gameLayer.remove(shoot); });
}
hero.onPulse(shoot, 100);

hero.say(font, "Allons y !");

// -----------------------------------------------------------------------------
// NE PAS MODIFIER LA PARTIE SUIVANTE DU CODE

include("CuteJet.include2");

