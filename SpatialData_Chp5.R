# Making maps in R
# Load Spatial data files into R
# Join data to GIS spatial data files
# Create a simple choropleth map
# Customize choropleth maps with tmap package

# Set the working directory and Load the data set
Census.Data <- read.csv("practical_data.csv")

# Load packages for shapefile loading and coordinate system setting
library("rgdal")
library("rgeos")
# Load packages for mapping data
library(tmap)
library(leaflet)

# Load the output area shapefiles
Output.Areas <- readOGR("C:\\JianingHe\\Learning Materials\\Spatial Data Analysis in R\\Camden\\Camden_oa11", "Camden_oa11")

# plot the shapefile
plot(Output.Areas)

# Join data - join Census.Data to the shapefile
OA.Cencus <- merge(Output.Areas, Census.Data, by.x = "OA11CD", by.y = "OA")

# Set a coordinate system - to map multiple different files - proj4string() & CRS()
# Set the coordinate system to the British National Grid (EPSG: 27700)
proj4string(OA.Cencus) <- CRS("+init=EPSG:27700")

# Create a quick map of qualification variable - target
qtm(OA.Cencus, fill = "Qualification")

# Create more advanced maps with tmap with customisation options
# 1. create a simple map
tm_shape(OA.Cencus) + tm_fill("Qualification")

# 2. Set the colour palette
library(RColorBrewer)
display.brewer.all()
tm_shape(OA.Cencus) + tm_fill("Qualification", palette = "-Greens")

# 3. Set the colour intervals (style = "equal", pretty, quantile, jenks or Cat)
tm_shape(OA.Cencus) + tm_fill("Qualification", style = "quantile", palette = "Reds")

# 4. Change the number of intervals to 7 instead of 5
tm_shape(OA.Cencus) + tm_fill("Qualification",
                              style = "quantile", 
                              palette = "Reds",
                              n = 7)

# 5. Include a histogram in the legend
tm_shape(OA.Cencus) + tm_fill("Qualification",
                              style = "quantile", 
                              palette = "Reds",
                              n = 7,
                              legend.hist = TRUE)
 
# 6. Add the borders - alpha: level of transparency (0, 1)
tm_shape(OA.Cencus) + tm_fill("Qualification",
                              style = "quantile", 
                              palette = "Reds",
                              n = 7,
                              legend.hist = TRUE) + tm_borders(alpha = 0.7)

# 7. Add north arrow
tm_shape(OA.Cencus) + 
  tm_fill("Qualification", style = "quantile", palette = "Reds") +
  tm_borders(alpha = 0.7) +
  tm_compass()

# 8. Edit the layout of the map using tm_layout()
tm_shape(OA.Cencus) + 
  tm_fill("Qualification", style = "quantile", palette = "Reds",
          title = '% with a Qualification') +
  tm_borders(alpha = 0.7) +
  tm_compass() +
  tm_layout(title = "Camden, London", legend.text.size = 1.1,
            legend.title.size = 1.4,
            legend.position = c("right", "top"),
            frame = FALSE)

# 9. Save the shapefile
writeOGR(OA.Cencus, dsn = "C:\\JianingHe\\Learning Materials\\Spatial Data Analysis in R\\Camden\\Camden_oa11",
         layer = "Census_OA_Shapefile",
         driver = "ESRI Shapefile")

