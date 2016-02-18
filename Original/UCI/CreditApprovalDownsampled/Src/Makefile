OBJS=binning.o
CC=g++ -std=c++0x
DEBUG = -g
CFLAGS = -Wall -c $(DEBUG)
LFLAGS = -Wall $(DEBUG)

all: binning clean

binning: $(OBJS)
	$(CC) $(LFLAGS) $(OBJS) -o binning

binning.o: binning.cpp
	$(CC) $(CFLAGS) binning.cpp

clean:
	\rm *.o
