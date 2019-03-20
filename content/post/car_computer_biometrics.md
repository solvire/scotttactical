---
title: "Biometric Vehicle Entry"
date: 2019-03-19T17:13:00-07:00
url: biometric-vehicle-entry-car-computer
draft: false
author: SScott
tags: ["car computer"]
comments: true
---


## Biometrics

From Wiki:

> Biometrics is the technical term for body measurements and calculations. It refers to metrics related to human characteristics. Biometrics authentication (or realistic authentication) is used in computer science as a form of identification and access control

Let the conspiracy theories abound.  Actually most of the worries before are no longer theories. The capabilities of the biometric tools now are such that the human mind may no longer be the master of the visual recognition spectrum. Machines are getting so fast and the collective store of algorithms are to the point that we can use out of the box software and some cobbling together to get pretty impressive results.  

Biometrics are (if I can simplify) the calculations and algorithms around determining what a personal looks like to a computer.  Stop imagining the Terminator.  It doesn't look like that although that is probably easier to stomach than what we actually look like.

{{% img src="images/car_computer/terminator.jpg" caption="Terminator Scanning Screen" %}}


75% of what I will be using is out of the box for basic functionality. Some of it is proprietary and owned by [Netki, inc](https://netki.com/) where I am currently employed.  We specialize in identity which we are really good at. And I love vehicles. So why not make a cool next-level project.  :) Right?

## Biometric Algorithms

Firstly I am using some generic tools from [dlib](http://dlib.net/) that help me get over the initial hump. Simple things like face detection and line detection are so common that everyone needs them.  You see them on your iPhone when you are starting to take a picture.  They are even optimized for running at the hardware level.  


{{% img src="images/car_computer/iphone-facial-recognition.jpg" caption="iPhone Facial Recognition" %}}


NOTE: I must give credit to [Adam Geitgey Medium](https://medium.com/@ageitgey/machine-learning-is-fun-part-4-modern-face-recognition-with-deep-learning-c3cffc121d78) where I am linking to some of the images. I will also be using part of his [face_recognition](https://github.com/ageitgey/face_recognition) library to get me over the entry tasks.

### Who Let the HOGs Out

So now that we know A face exists, then what.  we have to do things with it.  It is likely that we will have detected that a series of gradients or edges appear to fall into the same shape that a face might make.  These are fairly easy to spoof and we likely will get a lot of false positives.  However, it's a great place to get started. They are fast and light and we can use them in real time even with a video. A Histogram of Oriented Gradients or HOG would look like the grayscale image below. At least in this computer readable representation you can still sorta detect that it's a face. That is Will Ferrell BTW.

{{% img src="images/car_computer/hog1.png" caption="Histogram of Oriented Gradientsn" %}}

Now that we have the face detected we need to start breaking it down into its pieces.

### Facial Landmarking

In [2014, Vahid Kazemi and Josephine Sullivan](http://www.csc.kth.se/~vahidk/papers/KazemiCVPR14.pdf), a group of researchers in Sweden, came up with a novel way of determining the prominent landmarks on a human face.  It turns out it is very effective in mapping the points of interest on the face.  

The landmarks point out things like the under edge of the nose and inside of the eye.  Things that are directly tied to bone structure. It also points out features that are movable. Like the lips and eyelids. There are important distinctions in those variants. They mean different things to the computer and are used later in the anti-fraud tools.  

{{% img src="images/car_computer/dlib-landmark.png" caption="dlib facial landmarks" %}}

The facial landmark map consists of 68 points on the face. These can be connected to form something that looks like a cartoon cat.  They are always going to reference the same semantic points on the face so we can use those numeric points to make calculations specific to our use cases.



{{% img src="images/car_computer/obama_fl.jpg" caption="obama landmarks" class="right" %}}


Sometimes we don't need to calculate all the points and only need a couple to do minor landmark math. A smaller set is faster and easier to mess with.

{{% clear %}}

### Biometric Encoding

Now that we have numbers and vectors/locations we can start to use math on them to come up with some interesting data.  Here is what the computers really care about.  The rest has been a transitional process to get here.  

We have a fairly easy problem right now.  We have a very small set of faces as our authorized face set.  If you look at Facebook they will have billions of images and they are crossing them.  For our purposes I can take every frame and compare it against every image I have in our database of people who are authorized to drive this truck.  Let me try to explain how I am going to do that with a little bit of pseudo code.  

```
while (Images Coming From Camera):

  shrinkThePicture();

    if (Face From Camera) == (Authorized Face):

        Draw A Box Around The Face;
        Unlock The Truck;
```

### Facial Recognition

The next step it determining if the person who that image belongs to is the person that is in the video.  We have the encoding and it matched one set of encoding grids enough that we can say this is probably a person recognized in our data.  So let's label them and move them forward in the algorithm.

{{% img src="images/car_computer/face_detection.gif" caption="Face Recognition" %}}

Obviously it is kinda tough to recognize Faces. We assume that it is easy because we do it effortlessly but we have limitations that are greater than our estimates.

Obviously we do not want to detect other people who are NOT me. That would let them into the vehicle.

{{% img src="images/car_computer/baldwin_trump.gif" caption="Alec Baldwin Is Not Trump" %}}


## Conclusion

* There are a few easy steps in finding a face
* Out of the box technology gets us a very long way
* Right now there are easy ways to spoof the system but it takes a decent video or a good copy
* The more complex the calculations and algorithms the more power required to process

Later I will go into anti-fraud and anti-spoofing technology.  
