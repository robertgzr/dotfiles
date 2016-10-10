#!/bin/env zsh
#
# mpvp script to start mpv with content of the clipboard

function mpva()
{
    local chars=" █▄  "
    mpv --no-video --term-osd=force --term-osd-bar=yes --term-osd-bar-chars=$chars --term-playing-msg='> ${media-title}' --input-app-events=yes $@
}

# mpv for lazy me
function mpvp {
    local usage="""mpvp [-a] [mpv options]\n
    -a\tplays only audio\n
    (mpv cli flags can append)
    """
    local profile="--profile=cacheplus"
    local paste=${"$(pbp)"/ /}
    # eval paste before starting
    if [[ ! $paste =~ '^(http|https|rtmp):' ]]; then 
        echo "it seems '$paste' is not a URL!"
        return
    fi
    # mpvp main
    if [[ $1 = "-a" ]]; then
        echo "running: mpva ${@/-a/} $profile $paste";
        mpva "${@/-a/}" "$profile" "$paste";
    elif [[ $1 = "-h" ]]; then
            echo "$usage";
    else
        echo "running: mpv $@ $profile $paste"
        mpv "$@" "$profile" "$paste"
    fi
}