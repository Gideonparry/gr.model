data <- read.csv("C:\\Users\\bean_student\\Documents\\GraphData\\complete_data.csv")
data1 <- data
data$date <- as.Date(data$date)
View(data)
sum(is.na(data$date))
data1$date[which(is.na(data$date))]
as.Date("12/23/1965", tryFormats = c("%Y-%m-%d", "%Y/%m/%d", "%m/%d/%Y", "%m-%d-%Y"))
View(data1)
nchar("fa")
sum(which(nchar(data$city_code) != 4))
nrow(data)
nchar(data$city_code)[1:40]
sum(nchar(na.omit(data$building_code)) != 6)
View(data[which(nchar(data$city_code) != 4),])
sum(data$measurement == "roof" & is.na(data$mma))
View(data[which(data$measurement == "roof" & is.na(data$mma)),])
