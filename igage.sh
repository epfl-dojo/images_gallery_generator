#!/usr/bin/env bash

mkdir -p thumbnails

htmlstart () {
	echo "<html>";
	echo -e "\t<head>";
	# See https://codepen.io/ycw/pen/rZyZMa
	echo -e "\t\t<link rel='stylesheet' href='./style.css'>"
	echo -e "\t</head>";
}

htmlbody () {
	echo "<body>";
	echo -e "\t<h1>image gallery</h1>";
	echo -e "\t<ul>";
}

generateImageTag () {
	echo -e "\t\t<li><a href=\"images/$1\"><img src=\"thumbnails/$1\" /></a></li>";
}

htmlend () {
	echo -e "\t</ul>";
	echo "</body>";
	echo "</html>";
}

htmlstart > index.html;  
htmlbody >> index.html;

# for file in $(ls images/); do
for file in $(ls images/ | sort -R | tail -4); do
	if [ ! -f thumbnails/$file ]; then
    	convert -quiet images/$file -resize '250x250!' thumbnails/$file;
	fi
	generateImageTag $file >> index.html
done

htmlend >> index.html;