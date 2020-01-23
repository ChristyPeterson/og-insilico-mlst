#!/usr/bin/env perl -w
#
#Author: Christy Peterson
#Made: 20131209
#Last Edited:
#
#
#Purpose: To grab the allele profile for a tab-del list of NML numbers with st number for MLST
#
#Requires:  1) tab-del file with NML numbers in col 1, st's in col 2
#           2) tab-del file with most recent profile download from MLST website


use strict;
use warnings;

# get command-line arguments, or die with useage statement
my $useage  = "perl MLST-get_profile.pl <strains.txt> <profile.txt>\n";
my $strains_in  = shift or die $useage;
my $profile_in  = shift or die $useage;

#set up output file
open (OUT, '>results.txt');
print OUT "Key\tST\tabcZ\tbglA\tcat\tdapE\tdat\tldh\tlhkA\n";
close (OUT);

# read input file
my $line;
my $linenum;


open (FILE1, "$strains_in");
while ($line    = <FILE1>)
{
    $linenum++;
    #excluding the header, read the line into an array
    if($linenum != 1)
    {
        chomp $line;
        my @strain_line = split (/\t/,$line);
        #get the strain number's st
        my $strain_st   = $strain_line[1];
        
        #open up the profile table
        my $profile_line;
        my $profile_num;
        open (FILE2, "$profile_in");
        while ($profile_line = <FILE2>)
        {
            #excluding the header, read each profile into an array
            $profile_num++;
            if( $profile_num != 1)
            {
                chomp $profile_line;
                my @profile = split (/\t/, $profile_line);
                my $profile_st  = $profile[0];
                
                #compare the profile st with strain st and when it matches, write the strain number, st, and profile into the results file
                if ($profile_st == $strain_st)
                {
                    open (RESULT, '>>', 'results.txt');
                    print RESULT $strain_line[0]."\t";
                    print RESULT join ("\t", @profile);;
                    print RESULT "\n";
                    close (RESULT);
                }
            }
            
        }
    }
}


exit;
