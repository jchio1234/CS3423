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
    long waitPid;
    int exitStatus = 0;

    do
    {
        int repeat = 0;
        while(repeat == 0)
        {
            // Get user input
            printf("$ ");
            fgets(buffer, MAX_BUFFER, stdin);
            sscanf(buffer, "%[^\n]s", userInput);

            // If blank command, repeat the prompt
            if(strcmp(userInput, "") != 0)
                repeat = 1;
        }

        // Pass user input to parse function
        cmdparse(userInput, &cmd);

        // Create a child process
        forkPid = fork();

        switch(forkPid)
        {
            case -1:
                errExit("fork failed: %s", strerror(errno));
                break;
            case 0: // Child Process
                //printf("Child Process: PID=%ld, PPID=%ld\n", (long) getpid(), (long) getppid());
                execvp(cmd.argv1[0], cmd.argv1);
                fprintf(stderr, "parse error\n");
            default: // Parent process
                waitPid = wait(&exitStatus);
                if(waitPid == -1)
                    errExit("wait error: %s", strerror(errno));
                //printf("Parent Process: PID=%ld, PPID=%ld\n", (long) getpid(), (long) getppid());
                //printf("Parent Process: my child's PID=%ld\n", forkPid);
                //printf("Parent Process: wait pid=%ld\n", waitPid);
                //printf("Parent Process: exit status=%d\n", exitStatus);
        }
        //printf("My PID=%ld\n", (long) getpid());
    } while(strcmp(userInput, "exit") != 0);
    return 0;
}