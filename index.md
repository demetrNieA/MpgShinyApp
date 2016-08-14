---
title       : Test slidify presentation
subtitle    : We've reused calculations from 'Regression Models' class
author      : demetr
job         : 
framework   : io2012        # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
---

## Notes
* We used "Car fuel consumptions and emissions 2000-2013” dataset, all data can be found [here](http://data.okfn.org/data/amercader/car-fuel-and-emissions).
* Shiny app can be found [here](https://demetr.shinyapps.io/MpgShinyApp/).
* Github repository for this app: [link](https://github.com/demetrNieA/MpgShinyApp).
* Initial report: [link](http://rpubs.com/Demetr/202033).

--- .class #id 

## Dataset cleaning





```r
fuelCons <- fuelCons %>%
  filter(combined_imperial < 100, transmission_type != "") %>%
  mutate(transmission_typeX = as.factor(ifelse(transmission_type == 'Manual',
                                               'Manual', 'Automatic'))) %>%
  mutate(particulates_emissions = as.numeric(as.character(particulates_emissions)))
```

---  .class #id 

## Histogram of overall MPG for all vecicles

```r
histMPG <- qplot(combined_imperial,
                 data = fuelCons,
                 binwidth = 3,
                 xlab = "Average MPG of urban and extra urban tests",
                 ylab = "Count of cars")
```
![plot of chunk unnamed-chunk-5](assets/fig/unnamed-chunk-5-1.png)


---  .class #id 

## Relations between engine capacity, MPG and other characteristics
![plot of chunk unnamed-chunk-6](assets/fig/unnamed-chunk-6-1.png)
