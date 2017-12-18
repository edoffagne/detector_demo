library(shiny)
library(Rdarknet)
library(OpenImageR)

resize_image = function(infile, outfile)
{
  image = readImage(infile)
  # check if image is in landscape 
  if (dim(image)[1] < dim(image)[2])
  { width = 576
    height = 768
  }
  # else portrait 
  else
  { width = 768
    height = 576
  }
  resized = resizeImage(image, width = width,
                        height = height,
                        method = 'nearest')

  writeImage(resized, outfile)
}



# Define server logic to read selected file ----
server <- function(input, output) {
  
  output$myImage <- renderImage({

    req(input$file1)
    infile = input$file1$datapath
    # Resize the image to speedup the prediction
    resize_image(infile, infile)
    cat("Image resized...\n")
    dir = dirname(infile)
    outfile = paste0(dir, "/out2")
    # Run the model on the image
    tmp = run_detector(0.3, "data/yolo.weights",
                       "data/coco.dat", "data/yolo.cfg",
                       infile, outfile)
    result = paste0(outfile, ".png")
    cat(result)
    return(
      list(src = result,
           contentType = "image/png")
    )
  })

}

