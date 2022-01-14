pre-commit: ## Install and autoupdate pre-commit
	pre-commit install;
	pre-commit autoupdate;

clean: ## Remove .DS_Store file
	find . -type f -name ".DS_Store" | xargs rm -r;

imagemagick-resize-32-32: ## Resizes image to 32px by 32px. Sets overflow background to white.
	convert $$IN -resize 32x32 -background white -gravity center -extent 32x32 $$IN
