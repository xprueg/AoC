use strict;
use warnings;
use feature qw/ say state /;
use List::Util qw/ sum /;

use constant PART => $ARGV[0] // 1;

goto "PART_${\ PART}";

PART_1: {
    my $blinks = 25;
    my @input = map int, split q| |, <DATA>;

    say sum map blink($_, $blinks), @input;

    exit 0;
}

PART_2: {
    my $blinks = 75;
    my @input = map int, split q| |, <DATA>;

    say sum map blink($_, $blinks), @input;

    exit 0;
}

sub blink {
    state %buffer;
    my $stone = shift;
    my $blinks = shift;
    my $id = "${stone}:${blinks}";

    return $buffer{$id}
        if exists $buffer{$id};

    return 1
        if $blinks == 0;

    return ($buffer{$id} = do {
        if ($stone == 0) {
            blink(1, $blinks - 1);
        } elsif (length($stone) % 2 == 0) {
            my $l = length $stone;
            my ($lhs, $rhs) = (substr($stone, 0, $l/2),
                               substr($stone, $l/2, $l) =~ s/ ^ 0+ (?=( 0$ | [^0] )) //xr);
            blink($lhs, $blinks - 1) + blink($rhs, $blinks - 1);
        } else {
            blink($stone * 2024, $blinks - 1);
        }
    });
}

__DATA__
773 79858 0 71 213357 2937 1 3998391
