library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  output$modelPlot1 <- renderPlot({
    model_load <- paste("../data/",input$Model, "_model.RData", sep = "")
    load(model_load)
    model <- paste(input$Model,"_model", sep = "")
    model_var = as.symbol(model)
    plot(eval(model_var), main = paste(model, "plot", sep = " "))
  })
  output$modelPlot2 <- renderPlot({
    model_load <- paste("../data/",input$Model, "_model.RData", sep = "")
    load(model_load)
    model <- paste(input$Model,"_model", sep = "")
    model_var = as.symbol(model)
    if(model == "pcr_model" | model == "pcr_short_model"){
      validationplot(eval(model_var), main = "Validation Plot")
    }
  })
  
  output$MSE_combined <- renderPlot({
    
    #I want to change this to display the table of mean squared errors
    load('../data/MSE_ridge.RData')
    load('../data/MSE_pcr.RData')
    load('../data/MSE_lasso.RData')
    load('../data/ridge_model.RData')
    load('../data/lasso_model.RData')
    load('../data/pcr_model.RData')
    load('../data/MSE_short_ridge.RData')
    load('../data/MSE_short_pcr.RData')
    load('../data/MSE_short_lasso.RData')
    load('../data/ridge_short_model.RData')
    load('../data/lasso_short_model.RData')
    load('../data/pcr_short_model.RData')
    load('../data/hyp_results.RData')
    
    library(xtable)
    library(Matrix)
    options(xtable.caption.placement = 'top', xtable.comment = FALSE)
    MSE <- c(round(MSE_ridge, 4), round(MSE_short_ridge,4), round(MSE_lasso,4), round(MSE_short_lasso,4), round(MSE_pcr,4), round(MSE_short_pcr,4))
    Model <- c('Ridge', 'Short Ridge', 'Lasso', 'Short Lasso', 'PCR', 'Short PCR')
    mse.frame <- data.frame(Model, MSE)
    
    MSE_table <- xtable(mse.frame, caption="Information about Mean Squared Errors", digits = 3)
    plot(MSE_table, main = "MSE of all the models")
    text(MSE_table, labels = MSE, offset = .5, pos = 3)
    
  })
  
  
  
})