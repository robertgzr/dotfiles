#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

#define BUFSIZE 128

struct
{
    char branch[64];
    char remote[64];
    char commit[64];
    unsigned int ahead;
    unsigned int behind;
    unsigned int matches:2;
    unsigned int staged:2;
    unsigned int conflict:2;
    unsigned int unmerged:2;
    unsigned int changed:2;
    unsigned int untracked:2;
    unsigned int ignored:2;
} status;

int extract_branch(char* out)
{
    memcpy(status.branch, out+3, sizeof(status.branch));
    return 0;
}

int extract_commit(char *out)
{
    memcpy(status.commit, out, sizeof(status.commit));
    return 0;
}

int parse_status_output(char *raw_data)
{
    char index = raw_data[0]; // X
    char work = raw_data[1]; // Y

    /* branch */
    if ( index == '#' )
        extract_branch(raw_data);
        return 0;

    /* is untracked */
    if (index == '?')
        status.untracked = 1;
        return 0;

    /* is ignored */
    if (index == '!')
        status.ignored = 1;
        return 0;

    /* is changed */
    if ( work == 'M' || (work == 'D' && index != 'D') )
        status.changed = 1;
        return 0;

    /* is staged */
    if ( (index == 'D' && work != 'D') || (index == 'A' && work != 'A') )
        status.staged = 1;
        return 0;

    /* is conflict */
    if ( (index == 'M') || (index == 'R') || (index == 'C') || (index == 'A' && work == 'A') || (index == 'D' && work == 'D') )
        status.conflict = 1;
        return 0;

    /* is unmerged */
    if ( (index == 'U' || work == 'U' || index == work) && index != '?' && work != '!' )
        status.unmerged = 1;
        return 0;

    fprintf(stderr, "%s\n", "Not a match");
    return -1;
}

int make_output_to_shell();

int run_cmd(char *cmd)
{
    char buf[BUFSIZE];
    FILE *fp;

    if ((fp = popen(cmd, "r")) == NULL)
    {
        fprintf(stderr, "%s\n", "Error opening pipe");
        return -1;
    }

    while (fgets(buf, BUFSIZE, fp) != NULL)
    {
        size_t ln = strlen(buf)-1;
        if (buf[ln] == '\n')
            buf[ln] = '\0';
        parse_status_output(buf);
        extract_commit(buf);
        fflush(stdin);
    }

    if(pclose(fp))
    {
        fprintf(stderr, "%s\n", "Command not found or exited with error status");
        return -1;
    }
    return 0;
}

int tokenize_to_array(char *raw_data, char **token_array)
{
    char *tok;
    int i = 0;

    tok = strtok(raw_data, ". [,]");

    while (tok != NULL)
    {
        token_array[i] = tok;
        tok = strtok(NULL, ". [,]");
        i += 1;
    }

    return 0;
}

size_t arrlen(char **arr)
{
    size_t len = 0U;
    while (*arr++) ++len;
    return len;
}

int process_branch_data(char **token_array)
{
    int len = arrlen(token_array);
    if (len > 0)
    {
        memcpy(status.branch, token_array[0], 64);
    }
    if (len > 1)
    {
        memcpy(status.remote, token_array[1], 64);
    }
    if (len > 2)
    {
        status.ahead = atoi(token_array[3]);
    }
    if (len > 4)
    {
        status.behind = atoi(token_array[5]);
    }
    if (len > 7)
    {
        fprintf(stderr, "%s\n", "unexpected branch data");
        return -1;
    }
    return 0;
}

int make_output_to_shell()
{
    printf("%s,%s,%s,%i,%i,%i,%i,%i,%i,%i,%i,%i\n",
        status.commit,
        status.branch,
        status.remote,
        status.ahead,
        status.behind,
        status.matches,
        status.staged,
        status.conflict,
        status.unmerged,
        status.changed,
        status.untracked,
        status.ignored
    );
    return 0;
}

int main(int argc, char const *argv[])
{
    int a = run_cmd("git status --porcelain --branch --ignored 2>/dev/null");
    int b = run_cmd("git rev-parse --short HEAD 2>/dev/null");

    if (a+b < 0)
    {
        fprintf(stderr, "%s\n", "Not a git dir");
        make_output_to_shell();
        return 0;
    }

    // run_cmd("git status --porcelain --branch --ignored 2>/dev/null");
    // run_cmd("git rev-parse --short HEAD 2>/dev/null");

    char *token_array_g[6];
    tokenize_to_array(status.branch, token_array_g);

    process_branch_data(token_array_g);
    make_output_to_shell();
    return 0;
}