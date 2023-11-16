#OBJS specifies which files to compile as part of the project
OBJS = lex.yy.c,

#CC specifies which compiler we're using
CC = gcc

#INCLUDE_PATHS specifies the additional include paths we'll need
INCLUDE_PATHS = -IC:\mingw_lib\include\SDL2

#LIBRARY_PATHS specifies the additional library paths we'll need
LIBRARY_PATHS = -LC:\mingw_lib\lib

OBJ_NAME = gvloho

LINKER_FLAGS = -lmingw32 -lSDL2main -lSDL2

all : $(OBJS)
$(CC) *.c $(INCLUDE_PATHS) $(LIBRARY_PATHS) $(LINKER_FLAGS) -o $(OBJ_NAME)
