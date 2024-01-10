library(readxl)
library(ggplot2)
library(usmap)
library(gganimate) # important
library(transformr) # important

df <- read_excel("heatwaves.xlsx", sheet = "LA_all_data")
la <- df %>% 
  mutate(fips = `County Code`,
         heat_days = `Heat Wave Days Based on Daily Maximum Temperature`)


heat_anim <- plot_usmap(data = la, include = "LA", regions = "counties", values = "heat_days") +
  scale_fill_continuous(low = "white", high = "red", limits = c(0, 60)) +
  labs(title = "Number of Heat Wave Days in May - Sept., Louisiana",
       subtitle = "{closest_state}") + # corresponds to year
  transition_states(Year, 
                    transition_length = 2, # transitions are double in length
                    state_length = 1)

animate(heat_anim, fps = 10, duration = 30) # 30 second duration
# anim_save("heat_wave_change.gif")

