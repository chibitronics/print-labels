#!/bin/sh
print_usage() {
	echo "Usage: $1 [file-prefix-with-path]"
	echo "  For example: to print out labels in /tmp/ with the format 'bm-label-00XXX.png', run:"
	echo "$0 /tmp/bm-label-00"
	exit 1
}

if [ -z $1 ]
then
	print_usage "$0"
fi

# Hacky workaround to check for pattern matching
if [ $(echo ${1}* | wc -c) -eq $(echo "${1}*" | wc -c) ]
then
	echo "Unable to find any files matching the pattern."
	print_usage "$0"
fi

if [ ! -e /dev/usb/lp0 ]
then
	echo "Printer not attached!"
	exit 2
fi

for i in ${1}*
do
	echo "Printing $i..."
	brother_ql_create --model QL-570 --label-size 29 "$i" | dd of=/dev/usb/lp0
	sleep 2
done
