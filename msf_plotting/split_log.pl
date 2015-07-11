#!/usr/bin/perl
# Splits the log into the individual minutes ready for plotting

use strict;
use warnings;

my $filename = $ARGV[0];
open (my $infile, '<', $filename)
    or die "Could not open $filename";
my $subdir = $ARGV[1];   # this needs making first
                         # any name clashes will be overwritten

my $n=0;
my $outname = "${subdir}/${n}.txt";
open (my $outfile, '>', $outname);

while (my $line = <$infile>) {
    my $printline = $line;
    chomp $line;
    if ($line =~ /1,102/ || $line =~ /1,101/ || $line =~ /1,103/ || $line =~ /1,104/ || $line =~ /1,105/ || $line =~ /1,106/ || $line =~ /1,107/ || $line =~ /1,99/ || $line =~ /1,100/) {
	close($outfile);
	$n++;
	$outname = "${subdir}/${n}.txt";
	open ($outfile, '>', $outname);
    }
    print $outfile $printline;
}

print "\n";
