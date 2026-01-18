.PHONY: build upload upload_ip prepare
VENV_DIR = .venv

prepare:
	@echo "Creating Python virtual environment in $(VENV_DIR)..."
	python3 -m venv $(VENV_DIR)
	@echo "Activating virtualenv and installing requirements..."
	. $(VENV_DIR)/bin/activate && pip install -U pip && pip install -r requirements.txt
	@echo "PlatformIO installation complete. Activate with: . $(VENV_DIR)/bin/activate"
# Makefile for AWTRIX3 PlatformIO project
# Usage:
#   make build        - Build the firmware
#   make upload       - Upload via serial (default PlatformIO method)
#   make upload_ip IP=192.168.1.123  - Upload via OTA to device at IP

.PHONY: build upload upload_ip

# PlatformIO command
PIO = ./.venv/bin/platformio

build:
	$(PIO) run

upload:
	$(PIO) run --target upload

upload_ip:
	@if [ -z "$(IP)" ]; then \
		echo "Please specify IP, e.g. make upload_ip IP=192.168.1.123"; \
		exit 1; \
	fi; \
	$(PIO) run --target upload --upload-port=$(IP)
