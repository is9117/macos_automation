# Define variables
SCRIPT_GENERATOR := generate_scripts.sh
OUTPUT_DIR := ../../builds/browser
DEPLOY_DIR := /Applications

# Default target
all: generate

# Target to generate the scripts
generate:
	@echo "Running script to generate browser scripts..."
	@./$(SCRIPT_GENERATOR)

# Target to deploy the scripts to the Applications folder
deploy: generate
	@echo "Deploying scripts to $(DEPLOY_DIR)..."
	@cp -R $(OUTPUT_DIR) $(DEPLOY_DIR)/
	@echo "Scripts deployed to $(DEPLOY_DIR)"

# Target to clean up the generated scripts
clean:
	@echo "Cleaning up generated scripts..."
	@rm -rf $(OUTPUT_DIR)
	@echo "Cleaned up $(OUTPUT_DIR)"
