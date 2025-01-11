library(ggplot2)

# here is the inbuilt USA states data that will be used
map <- map_data('state')
map

# the following data has info on the states won per candidate per election cycle
elec <- read.csv(file.choose())
elec

# merging the elec data and the map data by the region column
# the state_low is just the state column formatted to lower case for merging purposes
electionmap <- merge(map, elec, by.x = 'region', by.y = 'state_low')

ggplot(electionmap, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group, fill = party_simplified))

USColors <- c('DEMOCRAT' = 'midnightblue',
              'REPUBLICAN' = 'firebrick')

ggplot(electionmap, aes(x = long, y = lat)) +
  geom_polygon(aes(group = group, fill = party_simplified), alpha = 0.8) +
  scale_fill_manual(values = USColors, name = '', labels = c('Democrat', 'Republican')) + 
  coord_quickmap() + 
  facet_wrap(vars(year)) +
  theme_void() +
  theme(legend.position = 'top',
        plot.title = element_text(size = 15, face = 'bold', hjust = 0.5, margin = margin(0, 0, 8, 0)),
        strip.text = element_text(face = 'bold', hjust = 0.4)) +
  labs(title = 'US Presidential Elections 1976-2020')

ggsave(filename = 'PresidentialelectionMap.jpeg')
