#!/usr/bin/perl
use strict;
use warnings;

my $filename = $ARGV[0];  # Specify your input file here
my $fh;
my $output;

print "reading: $filename\n";

open(my $infile, '<', $filename) or die "Could not open file '$filename' $!";

while (my $row = <$infile>) {
    chomp $row;
    if ($row =~ /=== (.*?) ===/) {
        close $fh if defined $fh;
        $output = $1 . ".csv";
        open($fh, '>', $output) or die "Could not open file '$output' $!";
    }
    else {
        print $fh "$row\n" if defined $fh;
    }
}

close $fh if defined $fh;
close $infile;