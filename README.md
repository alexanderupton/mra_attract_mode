# mra_attract_mode - arcade attract mode for MiSTer FPGA users<br>

## mra_attract_mode:<br>

#### Q: How to install mra_attract_mode ?<br>
<pre>wget --no-check-certificate https://raw.githubusercontent.com/alexanderupton/mra_attract_mode/main/mra_attract_mode.sh -P /media/fat/Scripts/</pre>

#### Q: How do I use mra_attract_mode ?<br>
mra_attract_mode can be executed through the interactive shell or through the MiSTer Menu's Scripts folder.

#### Q: What is the mra_attract_mode.ini file used for ?<br>
Users can define a MRA_TIME key value as a numeric digit to define the number of minutes each Arcade game will remain active before cycling to launch another random Arcade game.

#### Q: What is the MRA_TIME heiarchy ?<br>
- When mra_attract_mode is started without a numeric value passed at runtime and there is no value defined in mra_attract_mode.ini, the attract mode will default to 5 minutes before cycling to another Arcaade game.
- When mra_attract_mode is started without a numeric value passed at runtime and a MRA_TIME key value pair is defined in mra_attract_mode.ini, the attract mode will cycle to the next Arcaade game based on the defined MRA_TIME in minutes.
- When mra_attract_mode is started with a attribute numeric value at runtime, the runtime value will supercede any default or ini values and cycle to the next Arcade game based on the defined numeric runtime value in minutes.

#### Q: Why write mra_attract_mode ?<br>
A: I wanted a way to randomly cycle through available arcade cores to act as a screen saver and provide attract mode like functionallity without being locked to a single game.

#### Q: What's next ?<br>
1) Eventually expand the options to include support for Consoles.
2) Execution through the MiSTer Menu works, but is best managed via the shell as the menu does not have support to pass execution parameters to script executions. If there's any interest I can add a seperate stop wrapper that would be exposed via the menu.
3) Scheduled runtime. Any interest in an attract mode that would auto-execute or terminate based on a defined time value?

<pre>
mra_attract_mode <option> <attribute>
options:
   -start : Launch a random Arcade game every X minutes.
   -stop : Stop cycling through random Arcade games. Current game remains active.

attribute:
     number : number in minutes before mra_attract_mode cycles to launch a random Arcade Game

example:
     ./mra_attract_mode.sh -start 5
</pre>
