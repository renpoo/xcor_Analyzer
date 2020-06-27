# xcor_Analyzer
## -- Microscope for Sound and Music --

This xcor_Analyzer is based on an idea of Prof. K. ITO (Univ. of Tokyo), and implemented by me under his request.

"xcor" is stand for "Cross-Correlation Function", which is one-more-degree expansion of (well-known) "Correlation Coefficient" in Statistics.

Let us see the power of this xcor_Analyzer by examples.

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

