# lcurve

This XSLT script generates SVG files for a given Lindenmayer-System.

***

# Setup

1. Install an XSLT 2.0 interpreter like saxon-xslt, if not already available on your system.

# Usage

1. Open the file lcurve.xslt and in line 3, which states

<code>&lt;xsl:import href="hilbert.xslt" /&gt; &lt;!-- import l-rule set here--&gt;</code>

change <code>hilbert.xslt</code> to the l-rule set you want to use.

2. On the command line execute (for example):

$ saxon -xsl:lcurve.xslt -o:test.svg -it:main n=5 x=0 y=1024  width=1024 height=1024 direction=2 step=20

where

* -o:test.svg - defines the output SVG file
* n=5 - sets the recursion depth to 5
* x=0 - sets the starting point x coordinate to 0
* y=1024 - sets the starting point y ordinates to 1024
* width=1024 - sets the image width to 1024 pixels
* height=1024 - sets the image height to 1024 pixels
* direction=1 - sets the starting direction to east (0=north, 1=east, 2=south, 3=west)
* step=20 - sets the length of a line in one drawing step to 20 pixels

Note: All of these options, except the first can be omitted. If omitted, the default value (which are the above ones) for that option is being used.

# Defining L-Rule sets
## Example L-Rule sets within this repository
* hilbert.xslt - draws the Hilbert curve
* dragon.xslt - draws the dragon curve

## Supported drawing commands in L-Rule sets
* <code>&\lt;r/&\gt;</code> turns the current direction 90° to the right
* <code>&\lt;l/&\gt;</code> turns the current direction 90° to the left
* <code>&\lt;f/&\gt;</code> draws a line in the current direction with one step length

All other tags in l-rules are interpreted as variables (or constants).
