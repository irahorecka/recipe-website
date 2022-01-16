#### Standard Commands ####
## Install and autoupdate pre-commit
## E.g. $ make pre-commit
pre-commit:
	pre-commit install;
	pre-commit autoupdate;
## Remove .DS_Store file
## E.g. $ make clean
clean:
	find . -type f -name ".DS_Store" | xargs rm -r;
## Generate an array of flag images with various sizes.
## Flag images MUST come at a 3:2 aspect ratio (commonly 1200x800), have keyword 'flag' in filepath, and have a .png extension.
## E.g. $ make render-flag-images FLAG=recipe-website/assets/images/test-flag-1200px-800px.png
render-flag-images:
	$(eval BASE_FILEPATH := $(shell bash scripts/bash/fetch_path_before_keyword_flag.sh -p $(FLAG)))
	make imagemagick-resize-30-20 IN=$(FLAG) OUT=$(BASE_FILEPATH)-30px-20px.png
	make imagemagick-resize-150-100 IN=$(FLAG) OUT=$(BASE_FILEPATH)-150px-100px.png

#### Image Manipulation ####
### Crop 1:1 Aspect Ratio Images ###
## Resizes image to 32px by 32px. Sets overflow background to white.
imagemagick-resize-32-32:
	convert $(IN) -resize 32x32 -background white -gravity center -extent 32x32 $(OUT)
### Crop 3:2 Aspect Ratio Images ###
## Resizes image to 32px by 32px. Sets overflow background to white.
## E.g. $ make imagemagick-resize-30-20 IN=recipe-website/assets/images/test-flag-1200px-800px.png OUT=recipe-website/assets/images/test-flag-30px-20px.png
imagemagick-resize-30-20:
	convert $(IN) -resize 30x20 -background white -gravity center -extent 30x20 $(OUT)
## Resizes image to 32px by 32px. Sets overflow background to white.
## E.g. $ make imagemagick-resize-30-20 IN=recipe-website/assets/images/test-flag-1200px-800px.png OUT=recipe-website/assets/images/test-flag-150px-100px.png
imagemagick-resize-150-100:
	convert $(IN) -resize 150x100 -background white -gravity center -extent 150x100 $(OUT)
