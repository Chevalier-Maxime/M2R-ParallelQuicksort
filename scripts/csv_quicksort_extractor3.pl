#!/usr/bin/perl

use strict;use warnings;

my($line);
my($size);
my($seq,$par,$libc);

print "Opt, Size, Seq, Par, Libc\n" ;
while($line=<>) {
	chomp $line;
	if($line =~/^Size: ([\d\.]*)$/) {
		$size = $1;
	}
	
	$line=<>;
	chomp $line;
	if($line =~/^Sequential quicksort.*: ([\d\.]*) sec.$/) {
		$seq=$1;
	}
	
	$line=<>;
	chomp $line;
	if($line =~/^Parallel quicksort.*: ([\d\.]*) sec.$/) {
		$par=$1;
	}
	
	$line=<>;
	chomp $line;
	if($line =~/^Built-in quicksort.*: ([\d\.]*) sec.$/) {
		$libc=$1; 
		print "0, $size, $seq, $par, $libc\n";
	}
	
	$line=<>;
	chomp $line;
	if($line =~/^Sequential quicksort.*: ([\d\.]*) sec.$/) {
		$seq=$1;
	}
	$line=<>;
	chomp $line;
	if($line =~/^Parallel quicksort.*: ([\d\.]*) sec.$/) {
		$par=$1;
	} 
	$line=<>;
	chomp $line;
	if($line =~/^Built-in quicksort.*: ([\d\.]*) sec.$/) {
		$libc=$1; 
		print "1, $size, $seq, $par, $libc\n";
	}
	
	$line=<>;
	chomp $line;
	if($line =~/^Sequential quicksort.*: ([\d\.]*) sec.$/) {
		$seq=$1;
	}
	$line=<>; 
	chomp $line;
	if($line =~/^Parallel quicksort.*: ([\d\.]*) sec.$/) {
		$par=$1;
	} 
	$line=<>;
	chomp $line;
	if($line =~/^Built-in quicksort.*: ([\d\.]*) sec.$/) {
		$libc=$1; 
		print "2, $size, $seq, $par, $libc\n";
	}
	
	$line=<>;
	chomp $line;
	if($line =~/^Sequential quicksort.*: ([\d\.]*) sec.$/) {
		$seq=$1;
	}
	$line=<>;
	chomp $line; 
	if($line =~/^Parallel quicksort.*: ([\d\.]*) sec.$/) {
		$par=$1;
	} 
	$line=<>;
	chomp $line;
	if($line =~/^Built-in quicksort.*: ([\d\.]*) sec.$/) {
		$libc=$1; 
		print "3, $size, $seq, $par, $libc\n";
	}
}
__END__
