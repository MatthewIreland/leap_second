#!/usr/bin/perl

use strict;
use warnings;
use Math::NumberCruncher;
use List::Util qw(min max);

# Produces counts of servers with LI bits set.
# Preconditions: (i) file is sorted by date/time
#               (ii) no duplicate servers in each date/time slot

my $infilename = $ARGV[0];

open(my $infile, "<", $infilename) or die "Cannot open input file";

my $day, my $min, my $hour;
my $prev_min, my $prev_day, my $prev_hr;
my $server_count, my $li_set_count, my $li_clear_count; # for current time slot

my @server_counts = ();

$server_count=0;
$li_set_count=0;
$li_clear_count=0;
$prev_min = -1;

<$infile>;  # skip header line
while (my $line=<$infile>) {
    if ($line =~ /^(\d+),(\d+),(\d+),([0-9a-zA-Z:\.]+),\d,(.*)$/) {
    $day = $1;
    $hour = $2;
    $min = $3;

    my $li = $5;

#    print "$day $hour $min $3 $4 -- $li\n";
#    if ($li =~ /\+1s \(64\)/) {
#	print "  LI is 1\n";
#    }

    if (($prev_min != $min) && ($server_count != 0)) {
	print "${prev_day},${prev_hr},${prev_min},${server_count},${li_set_count},${li_clear_count}\n";
	push @server_counts, $server_count;
	$server_count = 0;
	$li_set_count = 0;
	$li_clear_count = 0;
    }

    $server_count++;
    if ($li =~ /\+1s \(64\)/) {
	$li_set_count++;
    } else {
	$li_clear_count++;
    }

    $prev_min = $min;
    $prev_day = $day;
    $prev_hr = $hour;
    }
}

print STDERR "Number of servers:";
print STDERR "\n  Mean: ", Math::NumberCruncher::Mean(\@server_counts);
print STDERR "\n  Median: ", Math::NumberCruncher::Median(\@server_counts);
print STDERR "\n  StDev: ", Math::NumberCruncher::StandardDeviation(\@server_counts);
print STDERR "\n  Min: ", min @server_counts;
print STDERR "\n  Max: ", max @server_counts;
print STDERR "\n";

