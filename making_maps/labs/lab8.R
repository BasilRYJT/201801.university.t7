# List of packages to load
lib <-c(
  #  "tidyverse",
  "lubridate",
  "readr",
  "ggplot2",
  "readxl",
  "dplyr"
)

# Load packages
for (item in lib){
  if (!require(item,character.only=TRUE)){
    install.packages(item)
    library(item,character.only = TRUE)
  }else{
    library(item,character.only = TRUE)
  }
}
rm(item)
rm(lib)

# Import data
acled <- read_csv("./02221-Lab7/acled-2015-2018.csv")

acled$EVENT_TYPE %>%
  table() %>%
  sort()
acled %>%
  filter(FATALITIES > 400)
acled %>%
  filter(FATALITIES > 400 & YEAR == 1998)
acled %>%
  select(EVENT_DATE, EVENT_TYPE, COUNTRY, FATALITIES)
acled %>%
  select(EVENT_DATE, EVENT_TYPE, COUNTRY, FATALITIES) %>%
  mutate(WEEKDAY = wday(EVENT_DATE))
acled %>%
  select(EVENT_DATE, EVENT_TYPE, COUNTRY, FATALITIES) %>%
  mutate(FATAL = FATALITIES > 0)
acled %>%
  select(EVENT_DATE, EVENT_TYPE, COUNTRY, FATALITIES) %>%
  mutate(FATAL = FATALITIES > 0) %>%
  filter(FATAL == TRUE) %>%
  filter(YEAR == 2009) %>%
  group_by(COUNTRY) %>%
  summarise(MEAN_FATALITIES = mean(FATALITIES))
fatalities.by.country <- acled %>%
  select(EVENT_DATE, EVENT_TYPE, COUNTRY, FATALITIES) %>%
  mutate(FATAL = FATALITIES > 0) %>%
  filter(FATAL == TRUE) %>%
  filter(YEAR == 2009) %>%
  group_by(COUNTRY) %>%
  summarise(MEAN_FATALITIES = mean(FATALITIES))
ggplot(acled, aes(EVENT_TYPE)) + 
  geom_bar()
ggplot(acled, aes(EVENT_TYPE)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
ggplot(acled, aes(EVENT_TYPE)) + 
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))
ggplot(acled, aes(EVENT_TYPE)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  xlab("Type of violent event") +
  ylab("Number of events"):
  ggtitle("Violent events in Africa 1997-2018")
acled %>%
  select(EVENT_DATE, EVENT_TYPE, FATALITIES) %>%
  group_by(EVENT_TYPE) %>%
  summarise(EVENT_COUNT = length(FATALITIES)) %>%
  ggplot(aes(x = reorder(EVENT_TYPE, -EVENT_COUNT), y = EVENT_COUNT)) +
  geom_bar(stat = "identity") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  xlab("Type of violent event") +
  ylab("Number of events") +
  ggtitle("Violent events in Africa 1997-2018")
ggplot(acled, aes(YEAR)) +
  geom_bar()
ggplot(acled, aes(YEAR)) +
  geom_bar() +
  scale_x_continuous(breaks = 1997:2018)
ggplot(acled, aes(YEAR)) +
  geom_bar() +
  scale_x_continuous(breaks = pretty(acled$YEAR, n = 10))
ggplot(acled, aes(YEAR)) +
  geom_bar() +
  scale_x_continuous(breaks = 2005:2015, limits = c(2004, 2016))
ggplot(acled, aes(YEAR, fill=EVENT_TYPE)) +
  geom_bar()
ggplot(acled, aes(YEAR, fill=EVENT_TYPE)) +
  geom_bar() +
  scale_fill_brewer(type = "qual", palette = 3)
ggplot(acled, aes(YEAR, fill = EVENT_TYPE)) +
  geom_bar(position = "dodge") +
  scale_fill_brewer(type = "qual", palette = 3)
ggplot(acled, aes(YEAR)) +
  geom_freqpoly(aes(group = EVENT_TYPE, colour = EVENT_TYPE), stat = "count") +
  scale_color_brewer(type = "qual", palette = 3)
ggplot(acled, aes(YEAR)) +
  geom_bar() +
  facet_grid(EVENT_TYPE ~ .)
ggplot(acled, aes(YEAR)) +
  geom_bar() +
  facet_grid(EVENT_TYPE ~ .) +
  theme(strip.text.y = element_text(angle = 0))
ggplot(acled, aes(YEAR)) +
  geom_bar() +
  facet_grid(EVENT_TYPE ~ ., scales = "free_y") +
  theme(strip.text.y = element_text(angle = 0))
ggplot(acled, aes(y = LATITUDE, x = LONGITUDE)) +
  geom_point(alpha = 0.4, aes(colour = EVENT_TYPE, size = FATALITIES)) +
  scale_size_area(max_size = 10) +
  facet_wrap(~ YEAR)