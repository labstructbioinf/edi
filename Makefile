

setup-install: # install
	pip install poetry mkdocs mkdocs-material
	#poetry install

serve: # run service
	poetry run mkdocs serve

deploy: # build and deploy
	poetry run mkdocs build && poetry run mkdocs gh-deploy