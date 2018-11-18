# Rules for building each .o
assign7.o: assign7.c assign7.h
	gcc -g -c assign7.c -o assign7.o

# Rules for building the executable
assign7: assign7.o
	gcc -g -o assign7 assign7.o

# Special rule to remove the .o files
clean:
	rm -f assign7.o