library(shiny)
library(dplyr)
library(knitr)
library(ggplot2)

########## Static initialization start ##########

fuelCons <- tbl_df(read.csv("https://raw.github.com/amercader/car-fuel-and-emissions/master/data.csv"))
# Downloading dataset. Details can be found on http://data.okfn.org/data/amercader/car-fuel-and-emissions

fuelCons <- fuelCons %>%
  filter(combined_imperial < 100, transmission_type != "") %>%
  mutate(transmission_typeX = as.factor(ifelse(transmission_type == 'Manual', 'Manual', 'Automatic'))) %>%
  mutate(particulates_emissions = as.numeric(as.character(particulates_emissions)))
# Cleaning data set

fit3 <- lm(urban_imperial ~ transmission_type + engine_capacity + fuel_type + year,
           data = fuelCons, na.action = na.exclude)
# Using best regression model. For details about why we choose this model please see
# http://rpubs.com/Demetr/202033

basePlot <- qplot(urban_imperial,
                  engine_capacity,
                  data = fuelCons,
                  col = fuel_type,
                  facets = transmission_type ~ .,
                  xlab = "MPG",
                  ylab = "Engine capacity, cc") +
  guides(colour = guide_legend(title = "Fuel type"))
# Generating base plot (will be used for all plots)

########## Static initialization end ##########

shinyServer(function(input, output) {

  output$mpgEst <- renderText({
    inputDF <- data.frame(
      transmission_type = input$transmission_type,
      fuel_type = input$fuel_type,
      engine_capacity = input$engine_capacity,
      year = input$year)
    predict(fit3, inputDF)
    
    # Predicting based on fitted model and user input
  })
  
  output$mpgPlot <- renderPlot({
    inputDF <- data.frame(
      transmission_type = input$transmission_type,
      fuel_type = input$fuel_type,
      engine_capacity = input$engine_capacity,
      year = input$year)
    inputDF$urban_imperial <- predict(fit3, inputDF)
    
    print(basePlot + geom_point(data = inputDF, size = 6, shape = 3, col = "black"))
    # We add additional point to base plot
  })

})
