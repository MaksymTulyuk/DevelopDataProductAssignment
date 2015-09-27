library(shiny)

shinyServer(function(input, output) {
  
  # set sliders depend on chosen type of distribution
  output$type <- renderUI({
    if (is.null(input$dist))
      return()
    
    switch(input$dist,
           "Binary" = wellPanel(sliderInput("obs", "Number of observations:", 
                                            min = 1, max = 1000, value = 100),
                                sliderInput("size", "Size:",
                                            min = 1, max = 10, value = 1),
                                sliderInput("prob", "Probability:", 
                                            min = 0, max = 1, value = 0.5)),
           "Normal" = wellPanel(sliderInput("obs", "Number of observations:", 
                                       min = 1, max = 1000, value = 100),
                           sliderInput("mean", "Mean:",
                                       min = 0, max = 10, value = 0),
                           sliderInput("sd", "SD:", 
                                       min = 1, max = 10, value = 1)),
           "Poisson" = wellPanel(sliderInput("obs", "Number of observations:", 
                                            min = 1, max = 1000, value = 100),
                                sliderInput("lambda", "Lambda:", 
                                            min = 1, max = 10, value = 1)),
           "Uniform" = wellPanel(sliderInput("obs", "Number of observations:", 
                                            min = 1, max = 1000, value = 100),
                                sliderInput("min", "Min:",
                                            min = 0, max = 10, value = 0),
                                sliderInput("max", "Max:", 
                                            min = 0, max = 10, value = 1))
    )
  })
  
  # generate distribution
  data <- reactive({
    if (is.null(input$dist))
      return()
    
    distribution <- switch(input$dist,
                           Binary = rbinom(input$obs, input$size, input$prob),
                           Normal = rnorm(input$obs, input$mean, input$sd),
                           Poisson = rpois(input$obs, input$lambda),
                           Uniform = runif(input$obs, input$min, input$max))
  })
  
  # show histogram
  output$distPlot <- renderPlot({
    switch(input$dist, 
           Binary = if (is.null(input$size)) return(),
           Normal = if (is.null(input$mean)) return(),
           Poisson = if (is.null(input$lambda)) return(),
           Uniform = if (is.null(input$min)) return())

    hist(data(), main = "Distribution histogram", xlab = "")
  })
})