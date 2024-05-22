# Define variables
SCRIPT_FILE := minimize.applescript
APP_NAME := HideYouTubeMusic
BUILD_DIR := ../../builds/google_music
APP_PATH := $(BUILD_DIR)/$(APP_NAME).app

# Default target
all: $(APP_PATH)

# Rule to compile the AppleScript into an application
$(APP_PATH): $(SCRIPT_FILE)
	@echo "Compiling $(SCRIPT_FILE) into $(APP_PATH)..."
	@mkdir -p $(BUILD_DIR)
	@osacompile -o $(APP_PATH) $(SCRIPT_FILE)
	@echo "Application '$(APP_NAME)' created successfully at $(APP_PATH)"

# Deploy target to copy the application to the Applications folder
deploy: $(APP_PATH)
	@echo "Deploying $(APP_NAME) to /Applications..."
	@cp -R $(APP_PATH) /Applications/
	@echo "$(APP_NAME) deployed to /Applications"

# Clean target to remove the compiled application
clean:
	@echo "Cleaning up..."
	@rm -rf $(APP_PATH)
	@echo "Cleaned up $(APP_PATH)"
