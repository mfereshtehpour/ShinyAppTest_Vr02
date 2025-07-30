

server <- function(input, output, session) {
  output$status <- renderText({
    if (input$go == 0) return("Waiting for click...")
    paste("Clicked", input$go, "times!")
  })
  
  output$plot <- renderPlot({
    hist(rnorm(100), col = "steelblue", main = "Random Histogram")
  })
}
