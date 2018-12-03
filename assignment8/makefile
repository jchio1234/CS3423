# Define the list of .o files for assign8
assign8OBJECTS = assign8.o cmdparse.o

# Rules for building each .o
assign8.o: assign8.c assign8.h
	gcc -g -c assign8.c -o assign8.o

cmdparse.o: cmdparse.c cmdparse.h
	gcc -g -c cmdparse.c -o cmdparse.o

# Rule for building the executable
assign8: ${assign8OBJECTS}
	gcc -g -o myshell ${assign8OBJECTS}

# Special rule to remove the .o files
clean:
	rm -f ${assign8OBJECTS}