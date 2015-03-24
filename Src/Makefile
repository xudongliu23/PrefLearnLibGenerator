OBJS=gen.o
CC=g++ -std=c++0x
DEBUG = -g
CFLAGS = -Wall -c $(DEBUG)
LFLAGS = -Wall $(DEBUG)

all: gen clean

gen: $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) -o gen

gen.o: gen.cpp
	$(CC) $(CFLAGS) gen.cpp

clean:
	\rm *.o
