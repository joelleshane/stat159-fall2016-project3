library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predicting Unemployment Rate"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "Model", label = "Choose a Model to run on the testing data",
                  choices = list("pcr", "ridge", "lasso", "pcr_short", "ridge_short", "lasso_short")
      )
    ),
    
    # Show Graphs corresponding to the models
    mainPanel(
      tabsetPanel(
        tabPanel("Model Graphs",
                 # fluidRow(...)
                 plotOutput("modelPlot1"),
                 plotOutput("modelPlot2")
        ),
        tabPanel("Compare MSE",
                plotOutput("MSE_combined")         
        )
      )
    )
    
    
  )
))
