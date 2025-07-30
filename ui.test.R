


ui <- fluidPage(
  titlePanel("Test App"),
  sidebarLayout(
    sidebarPanel(
      actionButton("go", "Click Me"),
      br(),
      textOutput("status")
    ),
    mainPanel(
      h3("Hello from UI2!"),
      plotOutput("plot")
    )
  )
)
