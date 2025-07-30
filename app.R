# app.R

library(shiny)
library(leaflet)
library(terra)
library(sf)
library(raster)
library(mapview)
library(leafpop)


ui <- fluidPage(
  titlePanel("Hello from Heroku!"),
  leafletOutput("mymap")
)

server <- function(input, output, session) {
  output$mymap <- renderLeaflet({
    leaflet() %>%
      addTiles() %>%
      addMarkers(lng = -79.3832, lat = 43.6532, popup = "Toronto")
  })
}

shinyApp(ui, server)

