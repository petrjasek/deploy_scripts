#!/bin/sh

url_safe ()
{
	echo $(echo "$1" | sed -e "s/[\/,\.,\,,\&,@,\(,\)]/_/g")
}
