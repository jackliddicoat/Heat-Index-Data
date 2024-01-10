library(patchwork)
library(readxl)
library(ggplot2)
library(usmap)

# laod the data in
# make sure to set your wd to wherever the the file is located in your computer
df <- read_excel("heatwaves.xlsx")

# make some changes to variable names
# make sure to name the county code column "fips"
heat <- df %>% 
  rename(heat_days = `Heat Wave Days Based on Daily Maximum Temperature`,
         fips = `County Code`)

# filter for 1981 and 2010
heat_81 <- heat %>% 
  filter(Year == 1981)
heat_10 <- heat %>% 
  filter(Year == 2010)

# make plots for both years

# 1981
plot1 <- plot_usmap(data = heat_81, regions = "counties", values = "heat_days") +
  scale_fill_continuous(limits = c(0, 60), low = "white", high = "red") +
  theme(legend.position = "right") +
  labs(title = "1981")

# 2010
plot2 <- plot_usmap(data = heat_10, regions = "counties", values = "heat_days") +
  scale_fill_continuous(low = "white", high = "red", limits = c(0, 60)) +
  theme(legend.position = "right") +
  labs(title = "2010")

# we can plot them next to each other using the "patchwork" package
labs = plot_annotation(title = "Number of Heat Wave Days, May - September, Based on Daily Maximum Temperature",
                       caption = "Data from CDC WONDER\nNote: Data is based on the 95th percentile of daily maximum air temperature")


plot1 + plot2 + labs

# this data is only for the continental United States, so we can exclude AK and HI

# 1981
plot1 <- plot_usmap(data = heat_81, regions = "counties", values = "heat_days",
                    exclude = c("AK", "HI")) +
  scale_fill_continuous(limits = c(0, 60), low = "white", high = "red") +
  theme(legend.position = "right") +
  labs(title = "1981")

# 2010
plot2 <- plot_usmap(data = heat_10, regions = "counties", values = "heat_days",
                    exclude = c("AK", "HI")) +
  scale_fill_continuous(low = "white", high = "red", limits = c(0, 60)) +
  theme(legend.position = "right") +
  labs(title = "2010")

plot1 + plot2 + labs

# We can also look at the plots like this
plot1 / plot2 + labs

# Louisiana looks interesting, lets look individually at that state

#1981
LA_81 <- plot_usmap(data = heat_81, include = "LA", values = "heat_days") +
  scale_fill_continuous(low = "white", high = "red", limits = c(0, 60)) +
  theme(legend.position = "right") + labs(title = "1981")
LA_81

#2010
LA_10 <- plot_usmap(data = heat_10, include = "LA", values = "heat_days") +
  scale_fill_continuous(low = "white", high = "red", limits = c(0, 60)) +
  theme(legend.position = "right") + labs(title = "2010")
LA_10

LA_81 + LA_10 +
  labs

# we can compare southern states and western states

s81 <- plot_usmap(data = heat_81, regions = "counties", include = .south_region,
           values = "heat_days") +
  scale_fill_continuous(low = "white", high = "red", limits = c(0, 60)) +
  labs(title = "1981")

s10 <- plot_usmap(data = heat_10, regions = "counties", include = .south_region,
                       values = "heat_days") +
  scale_fill_continuous(low = "white", high = "red", limits = c(0, 60),
                        guide = "none") +
  labs(title = "2010")

w81 <- plot_usmap(data = heat_81, regions = "counties", include = .west_region,
                       values = "heat_days", exclude = c("AK", "HI")) +
  scale_fill_continuous(low = "white", high = "red", limits = c(0, 60)) +
  labs(title = "1981")

w10 <- plot_usmap(data = heat_10, regions = "counties", include = .west_region,
                       values = "heat_days", exclude = c("AK", "HI")) +
  scale_fill_continuous(low = "white", high = "red", limits = c(0, 60),
                        guide = "none") +
  labs(title = "2010")

s81 + s10 + labs

w81 + w10 + labs

# Looks like the South has seen much larger increase
# in heat days than the West




