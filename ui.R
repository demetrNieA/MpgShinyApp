
library(shiny)

shinyUI(fluidPage(

  titlePanel("Estimating car MPG"),
  h3("This is a simple shiny application, which is using prediction model created in
     `Regression Models` class to estimate vecicle MPG based on several variables"),

  sidebarPanel(
    h2("Please enter your car characteristic:"),
    selectInput("transmission_type",
                "Transmission type of your car:",
                choices = c("Automatic", "Manual")),
    # We skiped fuel type `Electricity*` as we do not have enough data to predict.
    selectInput("fuel_type",
                "Fuel type:",
                choices = c("CNG", "Diesel", "Diesel Electric", "LPG", "LPG / Petrol",
                            "Petrol", "Petrol / E85", "Petrol / E85 (Flex Fuel)",
                            "Petrol Electric", "Petrol Hybrid")),
    sliderInput("engine_capacity",
                "Engine capacity, cc",
                min = 500,
                max = 8000,
                value = 25),
    sliderInput("year",
                "Year",
                min = 2000,
                max = 2013,
                value = 1)
  ),

  mainPanel(
    span("Estimated mpg for your car:",
         textOutput("mpgEst")
    ),
    # Plot with estimated car MPG.
    plotOutput("mpgPlot")
  ),
  
  span("We decide to use “Car fuel consumptions and emissions 2000-2013” dataset,
       as it has most current and applicable data. All data can be found on data.okfn.org
       web site:"),
  a("http://data.okfn.org/data/amercader/car-fuel-and-emissions")
))
