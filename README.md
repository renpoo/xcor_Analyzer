# xcor_Analyzer
## -- Microscope for Sound and Music --

This xcor_Analyzer is based on an idea of Prof. K. ITO (Univ. of Tokyo), and implemented by me under his request.

"xcor" is stand for "Cross-Correlation Function", which is one-more-degree expansion of (well-known) "Correlation Coefficient" in Statistics.

Let us see the power of this xcor_Analyzer by examples.


### Auto Correlation Function to view the periodicity of the time-dependent data

First of all, here is a sample sound file.

Let us listen to the voice.

https://github.com/renpoo/xcor_Analyzer/blob/master/_Sounds/TooBad.wav


This voice is mine, saying "Too Bad!", and recorded by the "binaural" stereo microphone like below.

![Binaural Microphone](https://github.com/renpoo/xcor_Analyzer/blob/master/images/BinauralMic.jpeg)

Analyzing this "Too Bad!" by xcor_Analyzer, we can see the resulting image like this.

![Too Bad (ACF)](https://github.com/renpoo/xcor_Analyzer/blob/master/images/01%20(TooBad.wav)%2CACF%20%5BLeft%20%3C-%3ERight%5D%2CtimeS0%2C0.00%2CtimeE0%2C1.40%2Ctau%2C0.010.png)

This image is a graph for "Travering Auto-Correlation Function".
Each time slices are like below, and the composite pakcage of these slices are the graph above.

![Too Bad (ACF) 01](https://github.com/renpoo/xcor_Analyzer/blob/master/images/(TooBad.wav)%2CACF%20%5BLeft%20%3C-%3ERight%5D%2CtimeS0%2C0.00%2CtimeE0%2C1.40%2Ct%2C0.331.jpg)

![Too Bad (ACF) 02](https://github.com/renpoo/xcor_Analyzer/blob/master/images/(TooBad.wav)%2CACF%20%5BLeft%20%3C-%3ERight%5D%2CtimeS0%2C0.00%2CtimeE0%2C1.40%2Ct%2C0.341.jpg)

![Too Bad (ACF) 03](https://github.com/renpoo/xcor_Analyzer/blob/master/images/(TooBad.wav)%2CACF%20%5BLeft%20%3C-%3ERight%5D%2CtimeS0%2C0.00%2CtimeE0%2C1.40%2Ct%2C0.351.jpg)

![Too Bad (ACF) 04](https://github.com/renpoo/xcor_Analyzer/blob/master/images/(TooBad.wav)%2CACF%20%5BLeft%20%3C-%3ERight%5D%2CtimeS0%2C0.00%2CtimeE0%2C1.40%2Ct%2C0.361.jpg)

![Too Bad (ACF) 05](https://github.com/renpoo/xcor_Analyzer/blob/master/images/(TooBad.wav)%2CACF%20%5BLeft%20%3C-%3ERight%5D%2CtimeS0%2C0.00%2CtimeE0%2C1.40%2Ct%2C0.371.jpg)

![Too Bad (ACF) 06](https://github.com/renpoo/xcor_Analyzer/blob/master/images/(TooBad.wav)%2CACF%20%5BLeft%20%3C-%3ERight%5D%2CtimeS0%2C0.00%2CtimeE0%2C1.40%2Ct%2C0.381.jpg)


What we are looking at (above) is "overtones" as each peaks.
This analyzer can caluculate the exact form of Correlation Function for each time slices in quantitative view.


This "ACF" graph from vartical top view is almost equivalent to the Spectrogram of the sound.
Let me cite the snapshot with Adobe Audition.

![Too Bad (ACF) Screen Shot](https://github.com/renpoo/xcor_Analyzer/blob/master/images/Screen%20Shot%20(ACF)%20Too%20Bad.png)

Thus, we can see the overtones of the sound in 3D view, with each tone lengths.


### Cross Correlation Function to view the time-space of the time-dependent data

Next, let us listen to this sound.
If you listen to this by headphone, you can easily find the voice is coming from right channel, moving to left channel.
https://github.com/renpoo/xcor_Analyzer/blob/master/_Sounds/Ah.wav

Analyzing this "Ah" by xcor_Analyzer, we can see the resulting image like this.

![Ah (ICCF)](https://github.com/renpoo/xcor_Analyzer/blob/master/images/03%20(Ah.wav)%2CICCF%20%5BLeft%20%3C-%3ERight%5D%2CtimeS0%2C0.00%2CtimeE0%2C1.75%2Ctau%2C0.010.png)

This is the image of "echo(s)" in "a room (sound environment)".
You can see the direct sound to the microphone, 1st. reflection, 2nd., 3rd., and so forth, visually and quantitatively.
