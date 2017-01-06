library(shiny)
library(leaflet)

shinyUI(fluidPage(

  # Application title
  headerPanel("Fort Meadow Reservoir Fishing Spot Locater"),
  
  sidebarPanel(
    selectInput("fishSpecie", "Specific Kind of Fish You're Looking to Catch (or All):", 
    c("All", "Largemouth Bass", "Smallmouth Bass", "Rainbow Trout", "Brown Trout", "Bluegill"), 
    selected = "All")
  ),
    
  mainPanel(
    leafletOutput("mymap", width = "100%", height = 500)
    )
))
