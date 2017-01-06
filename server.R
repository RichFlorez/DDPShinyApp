library(shiny)
library(leaflet)

ftMdwFish <- data.frame(
  lat = c(42.37154, 42.36587, 42.36939, 42.37085, 42.37510, 42.37462),
  lng = c(-71.54194, -71.55237, -71.55039, -71.53718, -71.53353, -71.53799),
  clr = c("green", "blue", "red", "blue", "red", "yellow"),
  urlLoc = c(
    "<a href='http://www.mafishfinder.com/fort-meadow-reservoir-25296-location.html'>Fort Meadow Reservoir</a>",
    "<a href='http://www.mafishfinder.com/brown-trout-7-fish.html'>Brown Trout</a>",
    "<a href='http://www.mafishfinder.com/largemouth-bass-13-fish.html'>Largemouth Bass</a>",
    "<a href='http://www.mafishfinder.com/rainbow-trout-16-fish.html'>Rainbow Trout</a>",
    "<a href='http://www.mafishfinder.com/smallmouth-bass-18-fish.html'>Smallmouth Bass</a>",
    "<a href='http://www.mafishfinder.com/bluegill-4-fish.html'>Bluegill</a>"),
  zm = c(15, 17, 17, 17, 17, 17)  
    )

lbl <- c("Info", "Trout", "Bass", "Sunfish")
  
arklogo <- makeIcon(
  iconUrl = "http://richflorez.github.io/DDPLeafletProject/arkstamp2.jpg",
  iconWidth = 31*215/230, iconHeight = 15,
  iconAnchorX = 31*215/230/2, iconAnchorY = 16)
 
shinyServer <- function(input, output, session) {
  fishInputLoc <- eventReactive(input$fishSpecie, {
    switch(input$fishSpecie,
           "All" = ftMdwFish,
           "Largemouth Bass" = ftMdwFish[3,],
           "Smallmouth Bass" = ftMdwFish[5,],
           "Rainbow Trout" = ftMdwFish[4,],
           "Brown Trout" = ftMdwFish[2,],
           "Bluegill" = ftMdwFish[6,])
  })  
  fishInputClr <- eventReactive(input$fishSpecie, {
    switch(input$fishSpecie,
           "All" = ftMdwFish[,3],
           "Largemouth Bass" = ftMdwFish[3,3],
           "Smallmouth Bass" = ftMdwFish[5,3],
           "Rainbow Trout" = ftMdwFish[4,3],
           "Brown Trout" = ftMdwFish[2,3],
           "Bluegill" = ftMdwFish[6,3])
  })  
  fishInputURL <- eventReactive(input$fishSpecie, {
    switch(input$fishSpecie,
           "All" = ftMdwFish[,4],
           "Largemouth Bass" = ftMdwFish[3,4],
           "Smallmouth Bass" = ftMdwFish[5,4],
           "Rainbow Trout" = ftMdwFish[4,4],
           "Brown Trout" = ftMdwFish[2,4],
           "Bluegill" = ftMdwFish[6,4])
  }) 
  fishInputZm <- eventReactive(input$fishSpecie, {
    switch(input$fishSpecie,
           "All" = ftMdwFish[1,5],
           "Largemouth Bass" = ftMdwFish[3,5],
           "Smallmouth Bass" = ftMdwFish[5,5],
           "Rainbow Trout" = ftMdwFish[4,5],
           "Brown Trout" = ftMdwFish[2,5],
           "Bluegill" = ftMdwFish[6,5])
  })
output$mymap <- renderLeaflet({
  leaflet() %>%
    addTiles() %>%
    addMarkers(data = fishInputLoc(), icon = arklogo, popup = fishInputURL()) %>%
    addLegend(labels = lbl, colors = c("green", "blue", "red", "yellow"), position = "bottomright") %>%         
    addCircleMarkers(data = fishInputLoc(), color = fishInputClr()) %>%
    setView(lat = fishInputLoc(), lng = fishInputLoc(), zoom = fishInputZm())

  })
}  

    
