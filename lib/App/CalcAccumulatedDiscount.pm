package App::CalcAccumulatedDiscounts;

# DATE
# VERSION

use 5.010001;
use strict;
use warnings;

our %SPEC;

$SPEC{calc_accumulated_discounts} = {
    v => 1.1,
    summary => 'Calculate multi-year discounts from a per-year discount rate',
    description => <<'_',

This routine generates a table of accumulated discounts over a period of several
years, given the annual discount rates.

_
    args => {
        years => {
            schema => ['array*', of=>'int*'],
            default => [5,10,15,20,25,30,35,40,45,50],
        },
        discounts => {
            schema => ['array*', of=>'float*'], # XXX percent
            default => [0.25, 0.5, 0.75, 1,
                        1.25, 1.5, 1.75, 2,
                        2.25, 3, 3.5, 4,
                        4.5, 5],
        },
    },
    examples => [
        { argv => [] },
    ],
    result_naked => 1,
};
sub calc_accumulated_discounts {
    my %args = @_;

    my $years = $args{years};
    my $discounts = $args{discounts};

    my $res = [];
    $res->[0][0] = 'Disc p.a. \\ Year';

    my $i = 0;
    for my $disc (@$discounts) {
        $i++;
        $res->[$i][0] = sprintf("%.2f%%", $disc);
        my $j = 0;
        for my $year (@$years) {
            if ($i == 1) {
                $res->[0][$j] = $year."y";
            }
            $j++;
            $res->[$i][$j] = sprintf("%.1f%%", (1 - (1-$disc/100)**$year)*100);
        }
    }

    $res;
}

1;
# ABSTRACT:

=head1 SYNOPSIS

See the included script L<calc-accumulated-discounts>.

=cut
