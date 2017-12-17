library(shiny)

# Define UI for data upload app ----
ui <- fluidPage(

  # App title ----
  titlePanel("YOLO Object Detector"),

  # Sidebar layout with input and output definitions ----
  sidebarLayout(

    # Sidebar panel for inputs ----
    sidebarPanel(

      # Input: Select a file ----
      fileInput("file1", "Choose Image File",
                multiple = TRUE,
                accept = c("image/gif",
                           "image/png",
                           "image/jpeg"))
    ),

    # Main panel for displaying outputs ----
    mainPanel(

      imageOutput("myImage")
    )

  )
)

