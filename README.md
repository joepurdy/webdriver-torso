# Shell script for creating [Webdriver Torso](https://www.youtube.com/channel/UCsLiV4WJfkTEHH0b9PmRklw) videos

### Example of script output
https://www.youtube.com/watch?v=Rx5qGqUT_I0

Usage
=======
```
webdriver-torso.sh [-h] [-v <number>] [-s <number>] [-t <text>] -- program to generate Webdriver Torso-esque video clips

where:
    -h  show this help text
    -v  set the number of videos to generate (default: 1)
    -s  set the number of slides to generate for each video (default: 10)
    -t  set the text that appears before each slide number (default: aqua.flv)
```

The process directory will be filled with working files while the script runs. The script cleans this directory up on its own. The generated videos will be output within the videos directory.

Prerequisites
=======
To use this script you need to first install a couple of cli tools that make the magic happen:

 - **ffmpeg:** This allows the script to combine the generated slide images and audio tones into a single .mp4 file. Grab the latest stable version from [ffmpeg.org](http://ffmpeg.org/). If your system already has a version installed but you've never used the tool there's a good chance it's outdated. You should go get the most recent stable version for your OS right meow.
 - **SoX:** No, this isn't some nifty tool for staying compliant with your Sarbanes–Oxley reporting. Instead it's the "Swiss Army knife of sound processing programs" (their words, not mine). The script depends on it for its synthesizer awesomeness to create the random audio tones in the Webdriver Torso videos. You can grab the latest release for your system on [Sourceforge](http://sourceforge.net/projects/sox/files/sox/)
 - **ImageMagick:** Image manipulation wundertool. Lets the script generate the individual slides in the videos. You can read more about it and grab the latest release for your system on the [ImageMagick homepage](http://imagemagick.org/)

**Note:** These tools must be in your system's PATH. (i.e. you can call them within the command line from anywhere). Also if you're on Windows you should probably be using a console emulator with msysgit so you can execute the `rm` command for cleanup. FWIW I use [cmder](http://cmder.net/) when I'm on a Windows PC and it gets the job done.