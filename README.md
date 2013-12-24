chromebook-verizon-usage-meter
==============================

A simple app to determine data usage on some chromebooks with Verizon Mobile Broadband.

Unfortunatly the Verizon Access Manager link disappeared from the version of ChromeOS on my Chromebook. 
So I whipped up this script to check the usage for me.


Requirements
------------

This script uses curl to get the data from verizon, grep to parse it, and bc to calculate the percent usage. 

Usage
--------

Open a terminal (ctrl+alt+t) and navigate to where you downloaded the script. Then simply:

./verizon_usage.sh

There are no options. After a moment, you should see the usage information pop up.
