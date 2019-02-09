use v6;
use lib 'lib';
use Test;
use Path::Finder;

constant AUTHOR = ?%*ENV<AUTHOR_TESTING>;

if AUTHOR {
    # check for use v6;
    my @dirs = '.';
    for find(@dirs, :ext(rx/ ^ ( 'p' <[lm]> 6? | t ) $ /), :skip-vcs) -> $file {
        my @lines = $file.lines;
        my $expected_line = 0;
        if @lines[0] eq '#!/usr/bin/env perl6' {
            $expected_line = 1;
        }
        $expected_line++ while @lines[$expected_line] eq '';
        like @lines[$expected_line], rx/use \s+ v6(\.c)?/, $file.Str;
    }
    done-testing;
}
else {
     plan 1;
     skip-rest "Skipping author test";
     exit;
}

