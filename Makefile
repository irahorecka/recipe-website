#### Standard Commands ####
## Install and autoupdate pre-commit
# E.g. $ make pre-commit
pre-commit:
	pre-commit install;
	pre-commit autoupdate;

## Remove .DS_Store file
# E.g. $ make clean
clean:
	find . -type f -name ".DS_Store" | xargs rm -r;

## Generate an array of flag images with various sizes.
## Flag images MUST come at a 3:2 aspect ratio (commonly 1200x800) and have keyword 'flag' in filepath.
# E.g. $ make render-flag-images IN=recipe-website/assets/images/test-flag-1200px-800px.png
render-flag-images:
	$(eval BASE_FILEPATH := $(shell bash scripts/bash/fetch_path_before_keyword.sh -p $(IN) -k flag)flag)
	$(eval FILE_EXT := $(shell bash scripts/bash/fetch_file_extension.sh -p $(IN)))
	make imagemagick-resize-30-20 IN=$(IN) OUT="$(BASE_FILEPATH)-30px-20px.${FILE_EXT}"
	make imagemagick-resize-150-100 IN=$(IN) OUT=$(BASE_FILEPATH)-150px-100px.${FILE_EXT}
	make imagemagick-crop-150-150 IN=$(IN) OUT=$(BASE_FILEPATH)-150px-150px.${FILE_EXT}


#### Image Manipulation ####
### Crop 1:1 Aspect Ratio Images ###
## Crops image to 150px by 150px. Sets overflow background to white.
# E.g. $ make imagemagick-crop-150-150 IN=recipe-website/assets/images/india-flag-1200px-800px.png OUT=recipe-website/assets/images/india-flag-150px-150px.png
imagemagick-crop-150-150:
	make imagemagick-crop W=150 H=150 IN=$(IN) OUT=$(OUT)

## Crops image to specified width and height. Sets overflow background to white.
# E.g. $ make imagemagick-crop W=150 H=150 IN=recipe-website/assets/images/india-flag-1200px-800px.png OUT=recipe-website/assets/images/india-flag-150px-150px.png
imagemagick-crop:
	$(eval EXT := $(shell bash scripts/bash/fetch_file_extension.sh -p $(IN)))
	$(eval IMG_WIDTH := $(shell bash scripts/bash/fetch_img_width.sh -p $(IN)))
	$(eval IMG_HEIGHT := $(shell bash scripts/bash/fetch_img_height.sh -p $(IN)))
	convert -define $(EXT):size=$(IMG_WIDTH)x$(IMG_HEIGHT) $(IN) -thumbnail $(W)x$(H)^ -gravity center -extent $(W)x$(H) $(OUT)

## Resizes image to 32px by 32px. Sets overflow background to white.
# E.g. $ make imagemagick-resize-32-32 IN=recipe-website/assets/images/demo.png OUT=recipe-website/assets/images/demo-32px-32px.png
imagemagick-resize-32-32:
	make imagemagick-resize W=32 H=32 IN=$(IN) OUT=$(OUT)

### Crop 3:2 Aspect Ratio Images ###
## Resizes image to 30px by 20px. Sets overflow background to white.
# E.g. $ make imagemagick-resize-30-20 IN=recipe-website/assets/images/test-flag-1200px-800px.png OUT=recipe-website/assets/images/test-flag-30px-20px.png
imagemagick-resize-30-20:
	make imagemagick-resize W=30 H=20 IN=$(IN) OUT=$(OUT)

## Resizes image to 150px by 100px. Sets overflow background to white.
# E.g. $ make imagemagick-resize-150-100 IN=recipe-website/assets/images/test-flag-1200px-800px.png OUT=recipe-website/assets/images/test-flag-150px-100px.png
imagemagick-resize-150-100:
	make imagemagick-resize W=150 H=100 IN=$(IN) OUT=$(OUT)

## Resizes image to specified width and height. Sets overflow background to white.
# E.g. $ make imagemagick-resize W=30 H=20 IN=recipe-website/assets/images/test-flag-1200px-800px.png OUT=recipe-website/assets/images/test-flag-30px-20px.png
imagemagick-resize:
	convert $(IN) -resize $(W)x$(H) -background white -gravity center -extent $(W)x$(H) $(OUT)
