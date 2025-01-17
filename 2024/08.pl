use strict;
use warnings;
use feature qw/ say /;

use constant PART => $ARGV[0] // 1;

goto "PART_${\ PART}";

PART_1: {
    my %antennas;
    my ($width, $height) = (0, 0);
    while (<DATA>) {
        chomp;
        $width = length() - 1;
        for (my $x = 0; $x < length; ++$x) {
            local $_ = substr $_, $x, 1;

            next if /\./;
            push $antennas{$_}->@* => { x => $x, y => $height };
        }

       ++$height unless eof DATA;
    }

    my %antinodes;
    for my $antenna (keys %antennas) {
        my @antennas = $antennas{$antenna}->@*;

        for (my $j = 0; $j < @antennas; ++$j) {
            my $a = $antennas[$j];

            for (my $i = $j; $i < @antennas; ++$i) {
                next if $j == $i;

                my $b = $antennas[$i];

                my $x1 = $a->{x} - ($b->{x} - $a->{x});
                my $y1 = $a->{y} - ($b->{y} - $a->{y});
                $antinodes{ $x1, $y1 } = 1
                    if $x1 >= 0 && $x1 <= $width && $y1 >= 0 && $y1 <= $height;

                my $x2 = $b->{x} - ($a->{x} - $b->{x});
                my $y2 = $b->{y} - ($a->{y} - $b->{y});
                $antinodes{ $x2, $y2 } = 1
                    if $x2 >= 0 && $x2 <= $width && $y2 >= 0 && $y2 <= $height;
            }
        }
    }

    say scalar keys %antinodes;

    exit 0;
}

__DATA__
..........M..........j.............y.....O........
...B...............q......m........lGO............
....................q......2.l.GQ...O.............
.....X.......................................4....
.....................q............................
....M......P...............xl.K.............2.....
....F.........L.......C.K..............m..........
..........FM......P....jy......m..........o...r...
..X.......P.....RL..............G..x..........4...
............L..........NC.....q...................
.....C.X...............K....y..........4..........
........S...R.............j.x.....V...4...........
.....................R..x.....V..i......m.........
...........................R.V......N.......X.....
.....F.........M......N......E....................
................v................T.......F......O.
.............................N...V.......Q........
...v.....................C.....i..................
......c.....W..n.w........................E.......
3...................c.....................Q..6....
...........h......................j...............
.......n.0......h.................E..............2
.v.............7.......120.....c..................
......n.0............w...........D.t.........E...r
....8..3......0.w.hP....z...D..T...............r..
.................f........T........G......eQ......
......f.n.....7..p................................
.....Y..7.......f......I......D......K............
............Uf....T..W.....D..r...i...............
......I...............................Z...........
....5....B.......b..............s..............Z..
..........d...W..Uwh.............c..........i.....
..I.3..Y......................e...................
.....p.b..........k......7........................
p...........k....I..b..........s..................
.....k.......o...........W........................
.A..Y..........U.................a........6.......
..A...Y.p...................................6.....
B......k..........................Z............u..
...3.....................s..............a.........
......A.........................g.....a...........
.......A....8...b.U......H....sS..................
.........................S1.............t.........
.....................9z..e.....5..1.g.u...........
.......................z....d....g....H.J....o.6..
........B................d.....u....9.J.H.........
.8........S.................u9.............J.....H
.....................Z5.............t1...........a
.....................e..v...................o..t..
.....8...............L.....z.............J........