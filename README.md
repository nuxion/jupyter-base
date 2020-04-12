Jupyter Docker Base
====================

This is a docker image for jupyter lab. The intention is avoid using conda as a python package manager. 
The image is base on Python Alpine version. 


How to use
===========

From docker hub:

```
~$ docker run nuxion/jupyterlab 

```

You can pass your own arguments if you want. 
By default this image use some custom env variables:

**JUPYTER_IP** = '0.0.0.0'
**JUPYTER_PORT** = 8888
**JUPYTER_BASE** = '/'
**JUP_PASS** = ''

This version has token disabled. 

How to customize the image
==========================

You can modify this image as you want. 
requirements file has the dependencies needed,
also `src/postBuild` could install plugins for jupyter. 

A `Makefile` is provided to help to build and push the image. It was made for my own use but could be modify very easy. 

Licensing
=========
Jupyter Docker Base is licensed under the Apache License, Version 2.0. See
[LICENSE](https://github.com/nuxion/jupyter-base/blob/master/LICENSE) for the full
license text.

