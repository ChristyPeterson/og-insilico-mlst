#!/usr/bin/env perl -w
#
#Author: Christy Peterson
#Made: 20130522
#Last Edited: 
#
#
#Purpose: To create MLST allele blast database files for insilico extraction
#
#Requires: folder containing all 7 loci allele download files, ie <abcZ.fasta>
#
#

use strict;
use warnings;

#------------------------------------------------------------------

#get command line arguments or die with useage statement
my $useage  = "perl mlstdb.pl <allele folder>\n";
my $directory   = shift or die $useage;

#read all allele files from directory
opendir (DIR, "$directory") || die "Can't opendir $directory: $!\n";
my @list    = grep/\.fasta$/, readdir(DIR);
closedir (DIR);

foreach my $dbfile (@list)
{
    my $in  = $directory.$dbfile;
    my $allele = substr($in, 0, -6);
    my $out = $allele."_DB";
    
    #run cmd to make blast database
    my $cmd = "makeblastdb -in $in -dbtype nucl -out $out";
    system ($cmd);

}

exit;