---
title: "Car Computer Face Recognition"
date: 2019-03-29T20:08:45-07:00
draft: false
author: SScott
url: car-computer-face-recognition
tags: ["car computer", "computer vision"]
comments: true

---

## Facial Recognition

### Computer Vision Libraries

#### OpenCV

#### dlib

## Installation

### cmake

This is simple enough. But it's worth calling out individually. If you do deep work with these binaries then you will start to mess with cmake. It's a bit tough to build binaries.

https://cmake.org/install/

  apt-get install cmake

### Install dlib on Ubuntu

The easiest way to install dlib is to install it with the bundled version with pip.

It may end up that you will need to compile dlib. It depends on how deep you are going into the framework.


  pip3 install dlib


If you have to compile this there may be a lot of features coming with it that aren't always needed. Things like guis and cameras.


  cd examples
  mkdir build
  cd build
  cmake ..
  cmake --build . --config Release

You will need this to install the face tools next.

### Install Face Recognition Repo

This library has been invaluable as a set of time saving tools for me.

https://github.com/ageitgey/face_recognition

https://face-recognition.readthedocs.io/en/latest/face_recognition.html

  pip3 install face-recognition==1.2.3

### Finish Python Install 
