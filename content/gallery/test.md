---
date: 2015-10-25T19:22:21-07:00
draft: true
title: A Test Gallery
tags: [photography, hugo, gallery]
---

# A sample gallery for hugo steve stuff 

<style type="text/css">
.my-gallery {
  width: 100%;
  float: left;
}
.my-gallery img {
  width: 100%;
  height: auto;
}
.my-gallery figure {
  display: block;
  float: left;
  margin: 0 5px 5px 0;
  width: 150px;
}
.my-gallery figcaption {
  display: none;
}
</style>

<div class="my-gallery" itemscope itemtype="http://schema.org/ImageGallery">
	    <figure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
      <a href="http://scott-tactical.s3-website-us-west-2.amazonaws.com/images/gallery/IMG_6330.jpg" itemprop="contentUrl" data-size="800x1200">
          <img src="http://scott-tactical.s3-website-us-west-2.amazonaws.com/images/gallery/IMG_6330_240.jpg" itemprop="thumbnail" alt="Mariah" />
      </a>
      <figcaption itemprop="caption description">Breakfast Erasor</figcaption>
    </figure>
    <figure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
      <a href="http://scott-tactical.s3-website-us-west-2.amazonaws.com/images/gallery/IMG_6331.jpg" itemprop="contentUrl" data-size="1200x800">
          <img src="http://scott-tactical.s3-website-us-west-2.amazonaws.com/images/gallery/IMG_6331_240.jpg" itemprop="thumbnail" alt="Image description" />
      </a>
      <figcaption itemprop="caption description">Image caption 2</figcaption>
    </figure>
    <figure itemprop="associatedMedia" itemscope itemtype="http://schema.org/ImageObject">
      <a href="http://scott-tactical.s3-website-us-west-2.amazonaws.com/images/gallery/IMG_6350.jpg" itemprop="contentUrl" data-size="1200x800">
          <img src="http://scott-tactical.s3-website-us-west-2.amazonaws.com/images/gallery/IMG_6350_240.jpg" itemprop="thumbnail" alt="Image description" />
      </a>
      <figcaption itemprop="caption description">Image caption 3</figcaption>
    </figure>
</div>



<!-- 
![test1](http://scott-tactical.s3-website-us-west-2.amazonaws.com/images/gallery/IMG_6330_240.jpg)
![test2](http://scott-tactical.s3-website-us-west-2.amazonaws.com/images/gallery/IMG_6331_240.jpg)
![test3](http://scott-tactical.s3-website-us-west-2.amazonaws.com/images/gallery/IMG_6350_240.jpg)
![test1](http://scott-tactical.s3-website-us-west-2.amazonaws.com/images/gallery/IMG_6330_240.jpg)

--> 