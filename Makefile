
help:
	@echo "make"
	@echo "    clean"
	@echo "        Remove Python/build artifacts."
	@echo "    install"
	@echo "        Install babelbot."
	@echo "    update"
	@echo "        Update babelbot."
	@echo "    install_rasa"
	@echo "        Install Rasa."
	@echo "    install_mecab"
	@echo "        Install mecab-ko."
	@echo "    check_mecab"
	@echo "        Activate mecab shell."
	@echo "    download_spacy"
	@echo "        Download spaCy Lang models."
	@echo "    formatter"
	@echo "        Apply black formatting to code."
	@echo "    lint"
	@echo "        Lint code with flake8, and check if black formatter should be applied."
	@echo "    types"
	@echo "        Check for type errors using pytype."
	@echo "    test"
	@echo "        Run pytest on tests/."

clean:
	find . -name '*.pyc' -exec rm -f {} +
	find . -name '*.pyo' -exec rm -f {} +
	find . -name '*~' -exec rm -f  {} +
	rm -rf .pytype/

install:
	# virtualenv 생성하지 않고 전역에 설치/관리하고 싶으면 아래와 같이 환경변수를 쉘 또는 bashrc 등에 반영
	# export POETRY_VIRTUALENVS_CREATE=false
	poetry run python3 -m pip install -U pip
	poetry install

install_rasa:
	pip install rasa
	pip install rasa-x -i https://pypi.rasa.com/simple

install_mecab:
	sh scripts/mecab-ko/install.sh

check_mecab:
	mecab -d /usr/local/lib/mecab/dic/mecab-ko-dic

download_spacy:
	spacy download xx
	spacy download en

update:
	poetry update
	make install

formatter:
	poetry run black babelbot tests

lint:
	poetry run flake8 babelbot tests
	poetry run black --check babelbot tests

types:
	poetry run pytype --keep-going babelbot -j 16

test: clean
	poetry run pytest tests
