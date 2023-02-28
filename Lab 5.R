library(shiny)

iris <- read.csv('C:\\Users\\Acer\\Documents\\COURSE\\UG Y2S2 (Jan 2023)\\DS\\Lab\\Iris.csv')
head(iris, 6)

ui <- fluidPage(
  titlePanel("Nigel's Shiny App"),
  sidebarLayout(
    sidebarPanel(
      selectInput(inputId = "dataset",
                  label = "Choose a dataset: ",
                  choices = c("rock", "pressure", "cars", "iris")),
      numericInput(inputId = "obs",
                   label = "Number of observations to view: ",
                   value = 10)
    ),
    mainPanel(
      tabsetPanel(type = "tabs",
        tabPanel("Summary", verbatimTextOutput("summary")),
        tabPanel("Table", tableOutput("table"))
      )
    )
  )
)

server <- function(input, output) {
  datasetInput <- reactive({
    switch(input$dataset,
           "rock" = rock,
           "pressure" = pressure,
           "cars" = cars,
           "iris" = iris)
  })
  
  output$summary <- renderPrint({
    dataset <- datasetInput()
    summary(dataset)
  })
  
  output$table <- renderTable({
    head(datasetInput(), n = input$obs)
  })
}

shinyApp(ui, server)