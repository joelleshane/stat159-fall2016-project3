library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$modelPlot1 <- renderPlot({
    model_load <- paste("../data/",input$Model, "_model.RData", sep = "")
    load(model_load)
    model <- paste(input$Model,"_model", sep = "")
    model_var = as.symbol(model)
    plot(eval(model_var))
  })
  output$modelPlot2 <- renderPlot({
    model_load <- paste("../data/",input$Model, "_model.RData", sep = "")
    load(model_load)
    model <- paste(input$Model,"_model", sep = "")
    model_var = as.symbol(model)
    if(model == "pcr_model"){
      validationplot(eval(model_var))
    }
  })
  
  output$MSE_combined <- renderPlot({
    
    #I want to change this to display the table of mean squared errors
    model_load <- paste("../data/",input$Model, ".RData", sep = "")
    load(model_load)
    model_var = as.symbol(input$Model)
    plot(eval(model_var))
  })
  
  
  
})