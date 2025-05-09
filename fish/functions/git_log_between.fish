function git_log_between
    argparse "author=?" "start_date=" "end_date=?" -- $argv

    if test -z "$_flag_start_date"
        echo "Usage: git_log_between --start_date <start_date> [--end_date <end_date>] [--author <author>]"
        return 1
    end

    if test -z "$_flag_end_date"
        set end_date "$_flag_start_date"
    else
        set end_date "$_flag_end_date"
    end

    set start_date "$_flag_start_date 00:00:00"
    set end_date "$end_date 23:59:59"

    # Run git log with a pretty format and the specified time range
    set command "git log --since=\"$start_date\" --until=\"$end_date\" --date=iso --pretty=format:\"%h %ad | %s %d [%an]\" --abbrev-commit"

    if set -q _flag_author
        set command "$command --author=\"$_flag_author\""
    end

    eval $command
end
