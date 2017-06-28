library(shiny)
library(datasets)

ui <- fluidPage(
  
  titlePanel("Petroleum Rock Data"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput( "variable", 
                   "Choose the rock characteristic to be displayed:",
                   choices = c( "Area of pores space in pixels", "Perimeter in pixels", 
                                "Shape as perimeter/sqrt(area)", "Permeability in milli-darcies")),
      
      sliderInput( "bins", 
                   "Number of bins:", 
                   min = 1, 
                   max = 40,
                   value = 20)
    ),
    
    mainPanel(
      plotOutput("rockPlot")
    )
  )
)

server <- function( input, output ) {
  
  variableInput <- reactive({
    switch(input$variable,
           "Area of pores space in pixels" = rock$area,
           "Perimeter in pixels" = rock$peri, 
           "Shape as perimeter/sqrt(area)" = rock$shape,
           "Permeability in milli-darcies" = rock$perm)
  })  
  
 
  
  output$rockPlot <- renderPlot({
    bins <- seq(min(variableInput()), max(variableInput()), length.out = input$bins +1)
    hist( variableInput(), breaks = bins, col = 'blue', border = 'white',
          main = paste("Petroleum Rock Charateristic:", input$variable), 
          xlab = input$variable)
    
  })
  
}

shinyApp( ui = ui, server = server )
