# Define the list of .o files for assign7
assign7OBJECTS = assign7.o
assign7INCLUDES = assign7.h

# Default rules for building .o
%.o: %.c ${assign7INCLUDES}
	gcc -g -c $<

# Rule for building the executable
assign7: ${assign7OBJECTS}
	gcc -g -o assign7 ${assign7OBJECTS}

# Special rule to remove the .o files
clean:
	rm -f ${assign7OBJECTS}