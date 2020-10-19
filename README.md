# Mac OS Ghost
Automatically forces your macbook to turn volume to max and dictate a dedicated phrase on a loop. It runs off a predetermined schedule.

Uses bash scripting and crontab. Works on Mac OS X.

### Background
I found the `say` feature in Mac OS' shell absolutely hilarious. It dictates anything passed in as arguments. I love pranking friends with this feature. My go usage was while friends were in the university library bathroom I would put a delay on `say` feature. Then when the delay expires, the computer spouts come embarassing line. Again, hilarious. Example: 
```bash
sleep 30s && say now downloading cheats for the chemistry test
#use s(seconds), m(minutes), h(hours), d(days)
```
Antoher was to infinitely loop saying the same word. Example:
```bash
while true; do say 'nerd nerd nerd nerd nerd nerd'; done
```

I wanted to prank another computer unaware friend, but after pulling several of the above they would never let me near their computer. They learnt the terminal window was the source of their troubles and would quickly close it whenever trouble arose, or just mute their computer.

### The Vision

I wanted the victim's computer to start screaming nonsense during their class for the ultimate embarrassment. Below are the problems I needed to solve to achieve my goal:
1. The bash script needs to run annonymously and automatically.
2. The bash script should be unfindable
3. I need a way to unmute their computer.
4. If user finds a way to mute the computer, there should be a contingency plan.
5. I need a way to maximize volume.
6. Everything should be able to install and operate without root(sudo).  
7. I originally wanted it to say a long sentence, but realized if it's saying something longer they could mute their computer and boom it's over.


The solutions I came up with:
1. Luckily I found `crontab` to solve this. It doesn't require root(sudo) to run and edit. Also it has it's own scheduling system for automation.
2. I will name the file as a dot file in an obscure section of their directory, so not just anyone can find it.
3. I found the already installed `osascript -e "set Volume"` command.
4. I need to loop over the `osascript` command to turn the volume back on max if muted.
5. I found the already installed `osascript -e "set Volume 10"` command, which sets the volume to max.
6. Crontab doesn't need root(sudo) privledges. There are no root permissioned commands within the script.
7. I made a string of one word repeated several times, then loop over to make the user think there's only one iteration and mute will solve the issue.


I tried several of the below commands to try and disable the keyboard and trackpad (inputs), but couldn't figure it out.

### What had happened was...

I was able to sneak onto thier computer with just enough time. I edited the crontab myself via terminal. Hid the script on their computer and waited. On the fateful day at 2:40pm(ten minutes after their class started), they were wearing headphones in class and the script started playing. The volume was turned all the way up in their headphones, so they removed them. They immediately realized what was happening and pressed mute. Problem solved, right?

Wrong! I predicted this! The second iteration of the loop kicked in. No longer wearing headphones the volume output coming from their device speakers littered the room with loud a "WIENER WIENER WIENER WIENER WIENER." Embarrassed and flustered they hit mute again. Perhaps the second time happened because they removed their headphones and it unmuted the computer? Problem solved!

That's when the third and final loop iteration began. "WIENER WIENER WIENER WIENER WIENER!" They closed their laptop, which finally stopped the digital harrassment. 

I received texts from a friend in the class saying it was a total success.

They responded by filling my entire bedroom with cups of water. It was definitely deserved. Also brilliant.


## Deployment

!!!PRANK RESPONSIBLY!!!

1. Clone the repo
2. Edit the `script.sh` in your prefered text editor to the desired loop iterations and said phrase.
3.	In your terminal run `chmod +x script.sh` to make the script executable in terminal.
4. Hide the script.sh within their file directory, but remember the path to it.
5. In your terminal run `crontab -e`. Based on the following crontab rules, set your time and script location:
```
	* * * * * "command to be executed"
	- - - - -
	| | | | |
	| | | | ----- Day of week (0 - 7) (Sunday=0 or 7)
	| | | ------- Month (1 - 12)
	| | --------- Day of month (1 - 31)
	| ----------- Hour (0 - 23)
	------------- Minute (0 - 59)
```
Example: `40 14 * * 1,3,5 /PATH/TO/script.sh` <- this will run script.sh at 2:40pm on Mondays Wednesdays and Fridays

6. Save and exit crontab, then wait and see!


### Further developments

- Should be able to disable keyboard and trackpad (inputs) while the script is running. Must be careful not to put that in an infinite loop.
- Dot file the script so it's unfindable in finder?
- Make a script you can run to implant bash script and copy crontab command.



Below are code snippets:
```bash
#!/bin/bash

number_of_loops=3
string_of_words="hello hello hello hello hello hello"

for run in {1..${number_of_loops}}
do
	osascript -e "set Volume 10"
	say ${string_of_words}
	osascript -e "set Volume 10"
done

```

```bash
chmod +x script.sh
```

``` bash
crontab -e
```

``` crontab 
# line explaination
* * * * * "command to be executed"
- - - - -
| | | | |
| | | | ----- Day of week (0 - 7) (Sunday=0 or 7)
| | | ------- Month (1 - 12)
| | --------- Day of month (1 - 31)
| ----------- Hour (0 - 23)
------------- Minute (0 - 59)
```
Example: `40 14 * * 1,3,5 /PATH/TO/script.sh` <- this will run script.sh at 2:40pm on Mondays Wednesdays and Fridays

This should copy info to the crontab
`(crontab -l 2>/dev/null; echo "*/5 * * * * /path/to/job -with args") | crontab -`
```
The 2>/dev/null is important so that you don't get the no crontab for username message that some *nixes produce if there are currently no crontab entries.```