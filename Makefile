# Makefile

# PHONY prevents issues with files/folders with the same names as makefile commands
.PHONY: help init venv run clean

VIRTUAL_ENV=venv
export VIRTUALENV_PATH := $(abspath ${VIRTUAL_ENV})

.DEFAULT: help
help:
	@echo "make venv --------------- Setup virtual Python3 environment ($(VIRTUAL_ENV))"
	@echo "make init --------------- Install python requirements in ($(VIRTUAL_ENV))"
	@echo "make clean -------------- Remove ($(VIRTUAL_ENV)) and installed subcomponents"

venv:
	python3 -m virtualenv $(VIRTUAL_ENV)
	[ -a data ] && echo "data folder already exists." || mkdir data
	@echo "-----"
	@echo "Environment ($(VIRTUAL_ENV)) installed in $(VIRTUALENV_PATH)"

init:
	@echo "installing requirements"
	pip install -r requirements.txt
	@echo "-----"
	@echo "personal finance app packages installed"
	@echo "-----"
	@echo "running integration tests."
	py.test test/integration.py

run:
	@echo "starting flaskapp."
	cd flaskapp && python3 flaskapp.py

clean:
	rm -rf $(VIRTUAL_ENV)
	@echo "-----"
	@echo "Deleted ($(VIRTUAL_ENV))"