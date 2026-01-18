.PHONY: build upload upload_ip prepare clean activate
VENV_DIR = .venv

prepare:
	@echo "Creating Python virtual environment in $(VENV_DIR)..."
	python3 -m venv $(VENV_DIR)
	@echo "Activating virtualenv and installing requirements..."
	. $(VENV_DIR)/bin/activate && pip install -U pip && pip install -r requirements.txt
	@echo "PlatformIO installation complete. Activate with: . $(VENV_DIR)/bin/activate"

activate:
	@if [ ! -d $(VENV_DIR) ]; then \
		echo "Virtualenv not found. Run 'make prepare' first."; \
		exit 1; \
	fi

clean:
	rm -rf .pio build .venv __pycache__

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
