#!/usr/bin/perl
use POSIX;
use strict;

my $num_files = `ls chibi_labels/*.png | wc -l`;
chomp ($num_files);

my $num_files_in_each_folder = 100;  # 100 files in each folder
my $folder_name = "serial_numbers/"; 
system ("mkdir $folder_name");

my $num_folder = ceil ($num_files / $num_files_in_each_folder);
my $file_index = 1;

print $num_folder;
print $num_files;

#$num_folder = 3;
#$num_files = 100;
for (my $i = 0; $i < $num_folder; $i++) {
	my $new_folder_name = $folder_name . "/" . $i . "/";
	system ("mkdir $new_folder_name");
	for (my $j = $file_index; $j < $file_index + $num_files_in_each_folder; $j++) {
		my $filename = "chibi_labels/label_" . sprintf ("%08d", $j) . ".png"; 
		if ($j <=  $num_files) {
			print "moving $filename\n";
			system ("mv $filename $new_folder_name");
		}	
		# $file_index++;
	}
        $file_index += $num_files_in_each_folder;
 }
