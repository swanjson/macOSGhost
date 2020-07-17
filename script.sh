#!/bin/bash

number_of_loops=3
string_of_words="hello hello hello hello hello hello"


for run in {1..${number_of_loops}}
do
	osascript -e "set Volume 10"
	say ${string_of_words}
	osascript -e "set Volume 10"
done