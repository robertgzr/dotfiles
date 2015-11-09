# ===== Basics

setopt ZLE
unsetopt BEEP
# If you type foo, and it isn't a command, and it is a directory in your cdpath, go there
setopt AUTO_CD

# Allow comments even in interactive shells (especially for Muness)
# setopt INTERACTIVE_COMMENTS

# disable start/stop characters in shell editor
unsetopt FLOW_CONTROL

setopt BRACE_CCL          # Allow brace character class list expansion.
setopt COMBINING_CHARS    # Combine zero-length punctuation characters (accents)
                          # with the base character.
# setopt RC_QUOTES          # Allow 'Henry''s Garage' instead of 'Henry'\''s Garage'.
# unsetopt MAIL_WARNING     # Don't print a warning message if a mail file has been accessed.

setopt MULTIOS              # Write to multiple descriptors.
setopt EXTENDED_GLOB        # Use extended globbing syntax.
unsetopt CLOBBER            # Do not overwrite existing files with > and >>.
                            # Use >! and >>! to bypass.


# ===== Jobs

setopt LONG_LIST_JOBS     # List jobs in the long format by default.
setopt AUTO_RESUME        # Attempt to resume existing job before creating a new process.
setopt NOTIFY             # Report status of background jobs immediately.
unsetopt BG_NICE          # Don't run all background jobs at a lower priority.
unsetopt HUP              # Don't kill jobs on shell exit.
unsetopt CHECK_JOBS       # Don't report on jobs when shell exit.

# ===== History

setopt APPEND_HISTORY              # Allow multiple terminal sessions to all append to one zsh command history
setopt INC_APPEND_HISTORY          # Add comamnds as they are typed, don't wait until shell exit
setopt HIST_IGNORE_DUPS            # Do not write events to history that are duplicates of previous events
setopt HIST_FIND_NO_DUPS           # When searching history don't display results already cycled through twice
setopt HIST_REDUCE_BLANKS          # Remove extra blanks from each command line being added to history
setopt EXTENDED_HISTORY            # Include more information about when the command was executed, etc (':start:elapsed;command')

# setopt BANG_HIST                 # Treat the '!' character specially during expansion.
setopt SHARE_HISTORY             # Share history between all sessions.
setopt HIST_EXPIRE_DUPS_FIRST    # Expire a duplicate event first when trimming history.
setopt HIST_IGNORE_ALL_DUPS      # Delete an old recorded event if a new event is a duplicate.
setopt HIST_IGNORE_SPACE         # Do not record an event starting with a space.
setopt HIST_SAVE_NO_DUPS         # Do not write a duplicate event to the history file.
setopt HIST_VERIFY               # Do not execute immediately upon history expansion.
setopt HIST_BEEP                 # Beep when accessing non-existent history.


# ===== Completion

setopt CORRECT               # correct commands
setopt COMPLETE_IN_WORD      # Allow completion from within a word/phrase
setopt ALWAYS_TO_END         # When completing from the middle of a word, move the cursor to the end of the word
setopt AUTO_MENU             # show completion menu on successive tab press
setopt AUTO_LIST             # Automatically list choices on ambiguous completion
setopt AUTO_PARAM_SLASH      # If completed parameter is a directory, add a trailing slash.
setopt PATH_DIRS             # Perform path search even on command names with slashes.
unsetopt MENU_COMPLETE       # do not autoselect first completion entry

WORDCHARS='*?_-.[]~&;!#$%^(){}<>'   # Treat these characters as part of a word.

# ===== Prompt

setopt PROMPT_SUBST          # Enable parameter expansion, command substitution, and arithmetic expansion in the prompt