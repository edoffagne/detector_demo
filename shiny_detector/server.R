library(shiny)
library(Rdarknet)
library(magick)

resize_image = function(infile, outfile, min_width=576)
{ 
  image = image_read(infile)
  info = image_info(image)
   # check if the image needs to be resized
  if (info$width > min_width)
  { # check if the image is in landscape
    if (info$height < info$width) width = min_width 
    # else portrait 
    else width = min_width 
    resized = image_scale(image, width)
    image_write(resized, path = outfile, format = "jpg")
  }
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

