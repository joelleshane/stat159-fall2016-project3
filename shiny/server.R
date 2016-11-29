library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  
  
  
  output$modelPlot1 <- renderPlot({
    model_load <- paste("../data/",input$Model, ".RData", sep = "")
    load(model_load)
    model_var = as.symbol(input$Model)
    validationplot(eval(model_var))
  })
  output$modelPlot2 <- renderPlot({
    model_load <- paste("../data/",input$Model, ".RData", sep = "")
    load(model_load)
    model_var = as.symbol(input$Model)
    plot(eval(model_var))
  })
  
  output$MSE_combined <- renderPlot({
    
    #I want to change this to display the table of mean squared errors
    model_load <- paste("../data/",input$Model, ".RData", sep = "")
    load(model_load)
    model_var = as.symbol(input$Model)
    plot(eval(model_var))
  })
  
  
  
})