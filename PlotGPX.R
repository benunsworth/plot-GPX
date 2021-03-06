library(plotKML)

# GPX files downloaded from Garmin Connect, Strava etc..
# Tell R where your GPX files are
setwd("~/<where_you_keep_your_files>")
files <- dir(pattern = "\\.gpx")

# Consolidate routes in one data frame
index <- c()
latitude <- c()
longitude <- c()
for (i in 1:length(files)) {
	
	route <- readGPX(files[i])
	location <- route$tracks[[1]][[1]]
	
	index <- c(index, rep(i, dim(location)[1]))
	latitude <- c(latitude, location$lat)
	longitude <- c(longitude, location$lon)
}
routes <- data.frame(cbind(index, latitude, longitude))

# Map the routes
ids <- unique(index)
plot(routes$longitude, routes$latitude, type="n", axes=FALSE, xlab="", ylab="", main="", asp=1)
for (i in 1:length(ids)) {
	currRoute <- subset(routes, index==ids[i])
	lines(currRoute$longitude, currRoute$latitude, col="#00000020")
}