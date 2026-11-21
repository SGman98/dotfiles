function git_log_between
    argparse "author=" "start_date=" "end_date=" -- $argv
    or return

    if not set -q _flag_start_date
        echo "Usage: git_log_between --start_date <start_date> [--end_date <end_date>] [--author <author>]"
        return 1
    end

    set -q _flag_end_date; or set _flag_end_date $_flag_start_date

    # Build the args as a list so values with quotes or spaces stay intact
    set -l args \
        --since="$_flag_start_date 00:00:00" \
        --until="$_flag_end_date 23:59:59" \
        --date=iso \
        --pretty=format:"%h %ad | %s %d [%an]" \
        --abbrev-commit

    set -q _flag_author; and set -a args --author="$_flag_author"

    git log $args
end
