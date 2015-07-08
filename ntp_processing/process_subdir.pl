#!/usr/bin/perl

use strict;
use warnings;
use File::Slurp;

# Takes directory of packet files and puts the key info into
# one file. Truncates timestamp to nearest 10 minutes.

# usage: arg 1 -- output file
#        arg 2 -- subdir to process

my $outfilename = $ARGV[0];
my $subdir = $ARGV[1];
my $file="";
my $file_contents="";

open (my $outfile, ">", $outfilename);

print $outfile "Day,Hour,10Min,IP,Stratum,LI";

my $day, my $hour, my $min, my $sec, my $ip, my $stratum, my $li;

my @packetfiles = <${subdir}/*>;
foreach $file (@packetfiles) {
    $file_contents = read_file($file);
    $file_contents =~ /(\d+)\.(\d+):(\d)\d:(\d+)\./;
    $day = $1;
    $hour = $2;
    $min = "${3}0";
    $sec = $4;

    $file_contents =~ /\s([0-9a-zA-Z:\.]+)\.123\s>/;
    $ip = $1;


    $file_contents =~ /Stratum\s(\d)\s/;
    $stratum = $1;

    $file_contents =~ /indicator:\s(.*),\sStratum/;
    $li = $1;

    print $outfile "${day},${hour},${min},${ip},${stratum},${li}\n";
}

close $outfile;
