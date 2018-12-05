#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdarg.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>
#include "assign8.h"
#include "cmdparse.h"

void errExit(const char szFmt[], ... )
{
    va_list args;               // This is the standard C variable argument list type
    va_start(args, szFmt);      // This tells the compiler where the variable arguments
    // begins.  They begin after szFmt.
    printf("ERROR: ");
    vprintf(szFmt, args);       // vprintf receives a printf format string and  a
    // va_list argument
    va_end(args);               // let the C environment know we are finished with the
    // va_list argument
    printf("\n");
    exit(ERROR_PROCESSING);
}

int main(int argc, char *argv[])
{
    char buffer[MAX_BUFFER];
    char userInput[MAX_BUFFER];
    CMD cmd;
    long forkPid;
    long forkPidPipe;
    long waitPid;
    int exitStatus = 0;
    int whileStatus = 1;
    int readFd, writeFd;
    int fdArr[2];

    while(whileStatus == 1)
    {
        int repeat = 0;
        while(repeat == 0)
        {
            // Clear userInput for repeat loops
            strcpy(userInput, "");

            // Get input from the user
            printf("$ ");
            fgets(buffer, MAX_BUFFER, stdin);
            sscanf(buffer, "%[^\n]s", userInput);

            // If blank command, repeat the prompt
            if(strcmp(userInput, "") != 0)
                repeat = 1;
        }

        // Break if user enters the "exit" command
        if(strcmp(userInput, "exit") == 0)
        {
            whileStatus = 0;
            break;
        }

        // Pass user input to parse function
        cmdparse(userInput, &cmd);

        // Create the pipe if the pipe command is present
        if(cmd.pipelining == 1)
            if(pipe(fdArr) == -1)
                errExit("pipe not created: %s", strerror(errno));

        // Create a child process
        forkPid = fork();

        switch(forkPid)
        {
            case -1:
                errExit("fork failed: %s", strerror(errno));
                break;
            case 0: // Child Process
                if(cmd.pipelining == 1)
                {
                    if (dup2(fdArr[1], STDOUT_FILENO) == -1)
                        errExit("Failed to redirect stdout for '%s': %s", cmd.argv1[0], strerror(errno));
                    close(fdArr[0]);
                    close(fdArr[1]);
                }
                execvp(cmd.argv1[0], cmd.argv1);
                fprintf(stderr, "parse error\n");
            default: // Parent process
                if(cmd.background != 1)
                    waitPid = wait(&exitStatus);
                if(cmd.pipelining == 1)
                {
                    forkPidPipe = fork();
                    switch(forkPidPipe)
                    {
                        case -1:
                            errExit("fork of second child failed: %s", strerror(errno));
                        case 0:
                            if(dup2(fdArr[0], STDIN_FILENO) == -1)
                                errExit("Failed to redirect stdin for '%s': %s", cmd.argv2[0], strerror(errno));
                            close(fdArr[0]); close(fdArr[1]);
                            execvp(cmd.argv2[0], cmd.argv2);
                            fprintf(stderr, "parse error\n");
                        default:
                            close(fdArr[0]); close(fdArr[1]);
                            fprintf(stderr, "PID for '%s': %ld, PID for '%s': %ld\n", cmd.argv1[0], forkPid, cmd.argv2[0], forkPidPipe);
                            fflush(stderr);
                    }
                }
        }
    }
    return 0;
}