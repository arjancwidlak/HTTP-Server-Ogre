use v6;
use lib 'lib';
use Test;
use Path::Finder;

constant AUTHOR = ?%*ENV<AUTHOR_TESTING>;

if AUTHOR {
    # check for trailing spaces
    # check for tabs
    my @dirs = '.';
    for Path::Finder.skip-vcs.ext(rx/ ^ ( 'p' <[lm]> 6? | t ) $ /).in(@dirs) -> $file {
        my @lines = $file.lines;
        my @spaces = @lines.grep(rx/\s$/);
        is-deeply @spaces, [], "spaces at the end of $file";

        my @tabs = @lines.grep(rx/\t/);
        is-deeply @tabs, [], "tabs in $file";
    }
    done-testing;
}
else {
     plan 1;
     skip-rest "Skipping author test";
     exit;
}

