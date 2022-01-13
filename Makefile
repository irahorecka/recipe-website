pre-commit: ## Install and autoupdate pre-commit
	pre-commit install;
	pre-commit autoupdate;

clean: ## Remove .DS_Store file
	find . -type f -name ".DS_Store" | xargs rm -r;
