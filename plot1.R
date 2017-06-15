library("dplyr")

file_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

dest_file <- "./Electric_power_data.zip"

download.file(url = file_url, destfile = dest_file)

data_dir <- "./raw-data/"

if(!dir.exists(data_dir)){
  dir.create(data_dir)
}

unzip(dest_file, exdir = data_dir)

pc_data <- read.table(file = paste0(data_dir, 
                                    "household_power_consumption.txt"),
                      stringsAsFactors = FALSE,
                      na.strings = "?",
                      header = TRUE,
                      sep = ";")

pc_data <- pc_data %>% 
  mutate(Date = as.Date(Date, format = "%d/%m/%Y")) %>% 
  filter(Date >= as.Date("2007-02-01") & Date <= as.Date("2007-02-02"))

pc_data[["datetime"]] <- strptime(paste(pc_data[["Date"]], pc_data[["Time"]]), 
                                  format = "%Y-%m-%d %H:%M:%S")

png(filename = "plot1.png")

hist(pc_data$Global_active_power, col = "red", 
     xlab = "Global Active Power (kilowatts)",
     main = "Global Active Power")

dev.off()
