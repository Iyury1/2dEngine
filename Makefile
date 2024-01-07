CXX := g++
CC := gcc
CFLAGS := -g -Wall
INC_DIR := include
LIB_DIR := lib
SRC_DIR := src
BUILD_DIR := build

TARGET := some_game

GLAD_HEADERS := $(wildcard $(LIB_DIR)/glad/*.h*)

GLFW_HEADERS := $(wildcard $(LIB_DIR)/glfw/*.h*)

KHR_HEADERS := $(wildcard $(LIB_DIR)/KHR/*.h*)

GAME_HEADERS := $(wildcard $(INC_DIR)/*.h*)
GAME_SOURCES := $(wildcard $(SRC_DIR)/*.cpp)
GAME_SOURCES += $(wildcard $(SRC_DIR)/graphics/*.cpp)
GAME_C_SOURCES := $(wildcard $(SRC_DIR)/*.c)

SRC_DIRS = $(SRC_DIR)
SRCS := $(shell find $(SRC_DIRS) -name *.cpp -or -name *.c)
OBJS := $(SRCS:%=$(BUILD_DIR)/%.o)

INCLUDES := -I$(INC_DIR)
INCLUDES += -I$(LIB_DIR)

LDFLAGS = -L$(LIB_DIR)/glfw
LIBS = -lglfw3 -lGL -lm -lX11 -lpthread -lXrandr -lXi -ldl


$(BUILD_DIR)/$(TARGET): $(OBJS)
	$(CXX) $(OBJS) -o $@ $(LDFLAGS) $(LIBS)

# c source
$(BUILD_DIR)/%.c.o: %.c | create_dirs
	$(CC) $(CPPFLAGS) $(CFLAGS) -c $< -o $@ $(INCLUDES)

# c++ source
$(BUILD_DIR)/%.cpp.o: %.cpp | create_dirs
	$(CXX) $(CPPFLAGS) $(CXXFLAGS) -c $< -o $@ $(INCLUDES)

create_dirs:
	@mkdir -p $(BUILD_DIR)
	@mkdir -p $(addprefix $(BUILD_DIR)/, $(SRC_DIRS))

.PHONY: clean create_dirs

clean:
	-rm -fR $(BUILD_DIR)