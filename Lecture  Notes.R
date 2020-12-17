# Scatter Plot
ggplot(data = midwest) + 
  geom_point(mapping = aes(x = percollege, y = 
                             percadultpoverty))

# Hexagonal Binning 
ggplot(data = midwest) + 
  geom_hex(mapping = aes(x = percollege, y = 
                             percadultpoverty))

# horizontal bar chart

ggplot(data = mpg) + 
  geom_bar(mapping = aes(x = hwy, fill = class))

# Pie chart

ggplot(data = mpg, aes(x = factor(1), fill = 
                         factor(cyl))) +
  geom_bar(width = 1) +
  coord_polar(theta = 'y')

# example of scales

ggplot(data = midwest) + 
  geom_point(mapping = aes(x = percollege, y = 
                             percadultpoverty, color = state))

# example of small multiples with facets
ggplot(data = mpg) +
  geom_point(mapping = aes(x=displ, y=hwy)) +
  facet_wrap(~class)


# interactive graph with plotly

mpg_graph <- ggplot(data = mpg) +
  geom_point(mapping = aes(x = displ, y 
                           = hwy))+
  facet_wrap(~class)

ggplotly(mpg_graph)

# interactive plot of iris flower set
plot_ly(
  data = iris,
  x = ~Sepal.Width,
  y = ~Petal.Width,
  color = ~Species,
  Type = "scatter",
  Mode = "markers"
) %>%
  layout(
    title = "Iris Data Set Visualization",
    xaxis = list(title = "sepal width", ticksuffix = "cm"),
    yaxis = list(title = "Petal width", ticksuffix = "cm")
  )

library(leaflet)

all_permits <- read.csv("/Users/stlp/Downloads/Building_Permits.csv")

# Filter for new buildings (2010 or later)

new_buildings <- all_permits %>%
  filter(all_permits$IssuedDate != "") %>%
  filter(
    PermitTypeDesc == "New",
    PermitClass != "N/A",
    as.Date(IssuedDate) >= as.Date("2010-01-01")
  )

leaflet(data = new_buildings) %>%
  addProviderTiles("CartoDB.Positron") %>%
  setView(lng = -122.3321, lat = 47.6062, zoom = 10) %>%
  addCircles(
    lat = ~Latitude,
    lng = ~Longitude,
    stroke = FALSE,
    popup = ~Description
  )



#### 15 API

library("httr")
# Create URI by combining base and resource
base_uri <- "https://api.github.com"
endpoint <- "/search/repositories"
uri_full <- paste0(base_uri, endpoint)

# Create a list of parameters that you want to use

query_params <- list(q="dplyr", sort = "forks")
response <- GET(uri_full, query = query_params)

# Create the query parameters
query_params <- list(q = "dplyr", sort = "forks")
# make request
response <- GET(uri_full, query = query_params)

# get response content, same thing as in the web browser
response_content <- content(response, "text")
cat(response_content)

library("jsonlite")
# get data from json
response_data <- fromJSON(response_content)
str(response_data)
names(response_data)

items <- response_data$items
is.data.frame(items)

# Flattening a nested dataframe

people <- data.frame(names = c('Spencer', 'Jessica', 'Keagan'))
favorites <- data.frame(
  food = c('Pizza', 'Pasta', 'Salad'),
  music = c('Bluegrass', 'Indie', 'Electronic'),
  stringsAsFactors = FALSE
)

# Store dataframe colomns
people$favorites <- favorites


people <- flatten(people)

# API Demo, Astronomy picture of the day lecture 15

# url: https://api.nasa.gov/planetary/apod this will say api missing.

# went here, https://api.nasa.gov:443

# nasa_api_key <- "ENTER KEY HERE"
#### Have to have api key saved as a variable as above in a file in same directory
# get api key, below is the file that holds the key.
source("nasa_api_key.R", echo = FALSE )

base_uri <- "https://api.nasa.gov"
endpoint <- "/planetary/apod"
uri_full <- paste0(base_uri, endpoint)

query_params <- list("api_key" = nasa_api_key)

response <- GET(uri_full, query = query_params)

response_content <- content(response, "text")

response_data <- fromJSON(response_content)
response_data$title

# Plot using the magick package
library(magick)
plot(image_read(response_data$url))

#### Notes on security. Actual file that has key get a gitignore.

### lecture 17 Shiny review


# shinyapps.io is a free service to deploy R


install.packages('rsconnect')

rsconnect::setAccountInfo(name='jmoney',
                          token='710828C6E2FEB702916B9B7AE0673101',
                          secret='<SECRET>')

## see shiny demo folder for scripts










