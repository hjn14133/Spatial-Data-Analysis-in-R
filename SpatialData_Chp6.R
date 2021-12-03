# Mapping point data into R
# create a point shapefile from a CSV using coordinates
# Map the points in tmap
# Create a proportional bubble map

# Set the working directory and Load the data set
Census.Data <- read.csv("practical_data.csv")

# Load the spatial libraries - polygon shapefile
library("rgdal")
library("rgeos")

# Load the output are shapefiles
Output.Areas <- readOGR(".", "Camden_oa11")

# Join our census data to the shapefile
OA.Cencus <- merge(Output.Areas, Census.Data, by.x = "OA11CD", by.y = "OA")

# load house prices csv files
houses <- read.csv("CamdenHouseSales15.csv")

# Select the specific columns needed
houses <- houses[, c(1, 2, 8, 9)]

# 2D scatter plot but not spatial data
plot(houses$oseast1m, houses$osnrth1m)

# Assign spatial attributes to the CSV
library("sp")

# Create a House.Points Spatial Points Data Frame
House.Points <- SpatialPointsDataFrame(houses[, 3:4], houses,
                                       proj4string = CRS("+init=EPSG:27700"))

# Map point data
library("tmap")

# Create a blank base map, set the transparency of the borders to 0.4
tm_shape(OA.Cencus) + tm_borders(alpha = 0.4)

# Add points data layer using tm_dots() with a coloured dot map
tm_shape(OA.Cencus) + tm_borders(alpha = 0.4) +
  tm_shape(House.Points) + tm_dots(col = "Price",
                                   scale = 1.5,
                                   palette = "Reds",
                                   style = "quantile",
                                   title = "Price Paid (L)") +
  tm_compass() +
  tm_layout(legend.text.size = 1.1, legend.title.size = 1.4,
            frame = FALSE)

# Create proportional symbol maps - tm_bubble()
tm_shape(OA.Cencus) + tm_borders(alpha = 0.7) +
  tm_shape(House.Points) + tm_bubbles(size = "Price", col = "Price",
                                      palette = "Blues", style = "quantile",
                                      legend.size.show = FALSE,
                                      title.col = "Price Paid") +
  tm_layout(legend.text.size = 1.1, legend.title.size = 1.5, frame = FALSE)

# Using polygon shapefile as basemap with proportional symbol map on top
tm_shape(OA.Cencus) + tm_fill("Qualification", palette = "Reds", 
                              style = "quantile", title = "% Qualification") +
  tm_borders(alpha = 0.4) +
  tm_shape(House.Points) + tm_bubbles(size = "Price", col="Price", 
                                      style="quantile", palette = "Blues",
                                      legend.size.show = FALSE,
                                      title.col = "House Price Paid (L)",
                                      border.col = "black", border.lwd = 0.1,
                                      border.alpha = 0.1) + 
  tm_layout(legend.text.size = 0.8, legend.title.size = 1.1, frame = FALSE)

# Save the shapefile
writeOGR(House.Points, dsn = "C:\\JianingHe\\Learning Materials\\Spatial Data Analysis in R\\Camden",
         layer = "Camden_house_sales",
         driver = "ESRI Shapefile")