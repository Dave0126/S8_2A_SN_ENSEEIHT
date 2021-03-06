# Output directory
OUT_DIR = ./build

# Tests directory
TEST_DIR = linda/test

# Source files
findSourceFiles = $(shell find . -name "*.java")
SOURCE_FILES = $(findSourceFiles) 

# Find all "*.class" files
DOLLAR_CHAR = \$
findTargetFile = $(shell (find . -name "*.class") | (sed 's/$(DOLLAR_CHAR)/\$(DOLLAR_CHAR)/g'))
TARGET_FILES = $(findTargetFile)

# Java compiler
JAVAC = javac

JAVAC_OPTIONS = -cp ".:./linda/dependencies/picocli-4.6.3.jar"

# Show help message
help:
	@echo ">>> make build : Compiles all Java source files."
	@echo ">>> make cli URL=<url>: Runs LindaCLI with specified 'url'"
	@echo ">>> make server ARGS=<args> : Runs LindaServerStarter with specified 'args'"
	@echo ">>> make clean : Clears files generated by compilation."
#	@echo ">>> make tests : Run all the tests in './linda/test' ."
	

# Compiles all "*.java"
build:
	@if $(JAVAC) $(JAVAC_OPTIONS) $(SOURCE_FILES); then \
		echo "Build succeed."; \
	else \
		echo "Build failed."; \
	fi

# Executes all tests
#tests:
#	$(foreach file, $(wildcard $(TEST_DIR)/*.java), java $(file);)

# Starts Linda CLI
cli:
	@echo [MAKE] Specify parameters by adding "URL=<url>"; \
	echo; \
	if java $(JAVAC_OPTIONS) linda/tools/cli/LindaCLI.java $(URL); then \
		echo ""; \
	else \
		echo "Failed running Java. Trying without '.java'..."; \
		java $(JAVAC_OPTIONS) linda/tools/cli/LindaCLI $(URL); \
	fi

# Starts Linda server
server:
	@echo [MAKE] Specify parameters by adding "ARGS=<parameters>"; \
	echo; \
	if java $(JAVAC_OPTIONS) linda/tools/serverstarter/LindaServerStarter.java $(ARGS); then \
		echo ""; \
	else \
		echo "Failed running Java. Trying without '.java'..."; \
		java $(JAVAC_OPTIONS) linda/tools/serverstarter/LindaServerStarter $(ARGS); \
	fi
	
# Clear classes generated
clean:
	@if rm -rf $(TARGET_FILES); then \
		echo "Clean done."; \
	else \
		echo "Clean failed."; \
	fi