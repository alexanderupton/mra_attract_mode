# mra_attract_mode - arcade attract mode for MiSTer FPGA users<br>

## mra_attract_mode:<br>

#### Q: How to install mra_attract_mode ?<br>
<pre>wget --no-check-certificate https://github.com/alexanderupton/mra_attract_mode/releases/download/v0.01/mra_attract_mode.sh -P /media/fat/Scripts/</pre>

#### Q: why write mra_attract_mode ?<br>
A: I wanted a way to randomly cycle through available arcade cores to act as a screen saver and provide attract mode like functionallity without being locked to a single game.

#### Q: what's next ?<br>
A: Eventually expand the options to include support for Consoles.

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
