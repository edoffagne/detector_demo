library(shiny)
library(Rdarknet)

# Define server logic to read selected file ----
server <- function(input, output) {
  
  output$myImage <- renderImage({

    req(input$file1)
    dir = dirname(input$file1$datapath)
    out = paste0(dir, "/out2")
    tmp = run_detector(0.3, "data/yolo.weights", "data/coco.dat", "data/yolo.cfg",
             input$file1$datapath, out)
    result = paste0(out, ".png")
    cat(result)
    return(
      list(src = result,
           contentType = "image/png")
    )
  })

}

