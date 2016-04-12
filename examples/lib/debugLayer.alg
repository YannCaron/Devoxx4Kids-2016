// function for debug level
set buildDebugLayer = function (stage) {
	set layer = stage.createLayer();

	// button
	set debugButton = layer.createButton(font, "black", "debug", stage.getWidth() - 200, stage.getHeight() - 70);
	set backButton = layer.createButton(font, "black", "back", stage.getWidth() - 100, stage.getHeight() - 70);

	// event
	debugButton.onTap ({ game.setDebug(!game.getDebug()); });
	backButton.onTap ({ game.goBack(); });

}
