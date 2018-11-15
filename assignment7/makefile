# Define the machine object file
OBJECTS = assign7.o
# Define the include file
INCLUDES = assign7.h

# Make for the executable
assign7: ${OBJECTS}
	gcc -g -o assign7 ${OBJECTS}

# Simple suffix rules for the .o
%.o: %.c ${INCLUDES}
	gcc -g -c $<

# Clean the .o files
clean:
	rm -f ${OBJECTS}
