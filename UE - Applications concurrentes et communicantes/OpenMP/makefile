# Show help message
help:
	@echo ">>> make build : 默认编译名为 'main.cpp' 的文件, 并运行生成的 'main.out' 文件"
	@echo ">>> make clean : 清除所有的 '*.out' 文件."

# C++ compiler
CPPC = clang++

# C compiler
CC = clang

# Find all "*.out" files
findTargetFile = $(shell find . -name "*.out")
TARGET_FILES = $(findTargetFile)

# build
file = "main"

build:
	$(CPPC) -o $(file).out $(file).cpp -Xpreprocessor -fopenmp -lomp
	./$(file).out

# clean
clean:
	rm -rf $(TARGET_FILES)