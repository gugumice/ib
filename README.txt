info-beamer for the Raspberry PI
--------------------------------

info-beamer allows you to develop interactive visualizations
using the Lua programming language. Read more about it on the main
website: https://info-beamer.com/pi/

The complete documentation for info-beamer is available on
https://info-beamer.com/doc/info-beamer

Be sure to read the (very short) license in LICENSE.txt

This release of info-beamer for the Raspberry PI is tested on
Raspbian "Wheezy" (hardfloat) and Raspbian "Jessie" (hardfloat).
Images for Raspbian are available on

    http://www.raspberrypi.org/downloads

Raspbian is also available as part of the NOOBS installer. Learn
more about it on http://www.raspberrypi.org/help/noobs-setup/




Installation
------------

Installing info-beamer depends on which Raspbian version you're
using. You can find out your Raspbian version by typing

    cat /etc/debian_version

If the command returns '8.0' you're using Raspbian jessie. If
it returns '7.0' you're still using the older version Wheezy.
Make sure you did download the correct version of info-beamer on:

    https://info-beamer.com/download/player

You have to install different dependencies depending on which
Raspbian you're using. Please have a look at the next two
section of this Readme to find out how to proceed depending
on your version.

Regardless of the version you're using, it is strongly
recommended to increase the memory available to the GPU.
Edit /boot/config.txt and increase gpu_mem. A minimum
of 192MB is recommended. If you don't provide enough GPU memory
image and video loading won't work!

If there is no gpu_mem line in /boot/config.txt, just add
the line

    gpu_mem=192

at the end of the file.

Make sure you have a power supply that provides enough power
to your PI. If you don't provide at least 2000mA things might
become unstable.




Installation on Raspbian Jessie
-------------------------------

You can install all required dependencies by running the
following commands:

   apt-get update
   apt-get install libevent-2.0-5 libavformat56 \
                   libpng12-0 libfreetype6 libavresample2




Installation on Raspbian Wheezy
-------------------------------

Be sure to update to the latest Raspberry PI firmware using
the command

   rpi-update

Once rpi-update finished, be sure to reboot your PI. Then
install the required dependencies:

   apt-get update
   apt-get install libevent-2.0-5 libavformat53 \
                   libpng12-0 libfreetype6 libavresample1





Usage
-----

That's all. info-beamer should work. You don't need a running
X server. Just start info-beamer from the command line.

To run any of the included examples, you can try these commands:

    ./info-beamer samples/hello

To stop info-beamer use Ctrl-C or press Escape.




Next steps
----------

Have a look at https://github.com/dividuum/info-beamer-nodes for
more example code.

Be sure to read the documentation to learn more about how info-beamer
works at https://info-beamer.com/doc/info-beamer

If you want to use info-beamer commercially be sure to buy a
license. Your support keeps the software alive. Thanks!




Notes about the PI version
--------------------------

 * There are some additional tools that might be useful to
   you when developing/deploying info-beamer on the PI. See
   https://github.com/info-beamer/tools

 * Background loading uses a fixed set of worker threads.
   The default number is 6. This is enough to load/play 6
   resources at once. If the limit is hit, loading another
   resource will block until one of the threads is available
   again. If you ever need more that 6 worker threads you
   can use INFOBEAMER_THREAD_POOL to specify the number
   of threads available for resource loading/playing:

   export INFOBEAMER_THREAD_POOL=12

 * Audio destination for the output can be controlled by

   export INFOBEAMER_AUDIO_TARGET=hdmi

   for output to HDMI or

   export INFOBEAMER_AUDIO_TARGET=local

   for output using the analog mini phone jack.

 * Hardware watchdog support. You can use the hardware watchdog
   support on the PI to automatically hard reboot the PI should
   info-beamer become stuck for X seconds. The recommended
   number for X is 5 seconds. To enable the watchdog, load
   the kernel module and set the following environment variable:

   modprobe bcm2708_wdog
   export INFOBEAMER_WATCHDOG=5

   You probably need root access to open the /dev/watchdog
   device file.




Known bugs
----------

No known bugs. Please get in contact if you find any problem.
