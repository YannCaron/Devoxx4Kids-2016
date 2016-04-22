// variables
set stage = game.createStage(0, 0);
//set tileLayer = stage.createTiledLayer("example");
set gameLayer = stage.createLayer();

set font = game.createFont("emulogic", 12, game.color.WHITE);

game.setDebug(true);
/*
set player = gameLayer.createActorAnim("Misc/Explosion", 4, 4, stage.getWidth() / 2, stage.getHeight() / 2);
player.typeStatic().hitPolygone(array {-50, -50, 50, -50, 50, 50, 0, 75, -50, 50});
*/
/*
tileLayer.tiledBackground("Background");
tileLayer.tiledBackground("Foreground");
*/

set hero = gameLayer.createActor("PlanetCute/beetleship");
hero.move(400, 400);
hero.typeDynamic().hitCircle(15);

hero.say(font, "Hi ALGEA !\nI am the beetle!");

stage.onTouch((x, y) { hero.move(x, y); });

set enemy1 = gameLayer.createActor("PlanetCute/Enemy Bug");
enemy1.move(200, 100);
enemy1.typeSensor().hitSquare().setGroupId(4);

set enemy2 = gameLayer.createActor("PlanetCute/Enemy Bug");
enemy2.move(100, 200);
enemy2.typeSensor().hitSquare().setGroupId(3);

hero.onContactWith(array {3, 4}, { print ("hit"); })
