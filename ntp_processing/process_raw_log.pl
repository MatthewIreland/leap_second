#!/usr/bin/perl

use strict;
use warnings;
use File::Slurp;

# Splits packets from tcpdump file into individual files ready for
# processing

# usage: arg 1 -- in file
#        arg 2 -- tmp subdirectory
#        arg 3 -- start day

#my $log = read_file($ARGV[0]);

my $infilename = $ARGV[0];
my $subdir     = $ARGV[1];

open(my $infile, "<", $infilename) or die "Cannot open input file";

my $packet_counter = 0;
my $canwrite=0;
my $day = $ARGV[2];
my $lastinc=0;

open (my $outfile, ">", "${subdir}/${packet_counter}.txt");

while (my $line=<$infile>) {
    if ($line =~ /.*Reference-ID.*/) {
	# close file
	close $outfile;
	$canwrite = 0;
	$packet_counter++;
    } elsif ($line =~ /(\d+):(\d+):(\d+)\..*/) {
	if (($1=="00") && ($2=="00")) {
	    if (($packet_counter-$lastinc) > 1000) {
		$day++;
		$lastinc = $packet_counter;
	    }
	}
	my $filenumber = sprintf("%08d", $packet_counter);
	open ($outfile, ">", "${subdir}/${filenumber}.txt");
	print $outfile "${day}.";
	$canwrite = 1;
    }
    if ($canwrite) {
	print $outfile "$line\n";
    }
}
