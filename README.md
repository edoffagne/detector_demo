# A Shiny app that exposes an image object detector 

## Introduction

This is a Shiny app runs a pre-trained model to detect objects
on the image uploaded by the user. The R package [Rdarknet]( https://github.com/edoffagne/Rdarknet.git) is used to run the model implemented with 
[darknet](https://pjreddie.com/darknet/)

A demo of the app is available [here](https://erikdf.shinyapps.io/shiny_detector).
   
## Installation

In order to run this app you need first to download the [weights file](https://pjreddie.com/media/files/yolo.weights) and put it in the data folder.

Then you need to install the Rdarknet package with the command below:

```shell
$ R -e "devtools::install_github('edoffagne/Rdarknet')"
 ```
Finally you can run it locally:

```shell
require(shiny)
run_detector("shiny-detector")
```


