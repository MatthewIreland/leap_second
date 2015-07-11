#!/usr/bin/perl

use strict;
use warnings;

my $filename = $ARGV[0];
open (my $fh, '<', $filename)
    or die "Could not open $filename";

my $time=0;
my $increment=0.005;   # 5ms increment

while (my $line = <$fh>) {
    chomp $line;
    my @currentLine = split(',', $line);
    for (my $i=0; $i<$currentLine[1]; $i++) {
	print "$time,$currentLine[0]\n";
	$time+=$increment;
    }
}

print "\n";
