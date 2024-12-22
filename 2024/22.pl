use strict;
use warnings;
use List::Util qw/ sum /;
use feature qw/ say state /;

use constant PART => $ARGV[0] // 1;

goto "PART_${\ PART}";

PART_1: {
    say sum map { evolve(2_000) } <DATA>;

    exit 0;
}

sub evolve {
    my $secret = $_;
    my $iterations = shift;

    for (1..$iterations) {
        $secret = prune(mix($secret, $secret * 64));
        $secret = prune(mix($secret, int($secret / 32)));
        $secret = prune(mix($secret, $secret * 2048));
    }

    return $secret;
}


sub mix {
    shift() ^ +shift();
}

sub prune {
    shift() % 16777216;
}

__DATA__
1
2
3
2024
