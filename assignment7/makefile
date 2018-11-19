# Define the list of .o files for assign7
assign7OBJECTS = assign7.o

# Rules for building each .o
assign7.o: assign7.c assign7.h
	gcc -g -c assign7.c -o assign7.o

# Rule for building the executable
assign7: ${assign7OBJECTS}
	gcc -g -o assign7 ${assign7OBJECTS}

# Special rule to remove the .o files
clean:
	rm -f ${assign7OBJECTS}