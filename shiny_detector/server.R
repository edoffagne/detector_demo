library(shiny)
library(Rdarknet)
library(magick)

resize_image = function(infile, outfile)
{ 
  image = image_read(infile)
  # check if image is in landscape
  info = image_info(image) 
  if (info$height < info$width) width = 576 
  # else portrait 
  else width = 768 
  resized = image_scale(image, width)
  image_write(resized, path = outfile, format = "jpg")
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

