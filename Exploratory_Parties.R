library(ggplot2)
library(magrittr)
X <- read.table(
  "Polit_Affiliation_MPs.csv",
  header = TRUE,
  sep = ","
)
attach(X)

afd_blue <- "#0088ff"
cdu_orange <- "#FF9900"
fdp_yellow <- rgb(1, 237 / 255, 0)
greens_green <- "#46962b"
left_purple <- "#980267"
spd_red <- "#FF0000"
  
View(X)

boxplot(
  listed_count[followers_count < 100000] ~ party[followers_count < 100000], 
  main = "# Tweets by Party",
  xlab = "Party",
  ylab = "# Tweets",
  col = c(afd_blue, cdu_orange, fdp_yellow, greens_green, left_purple, spd_red)
)
options(scipen = 10)

screen_name <- as.character(screen_name)
party <- as.character(party)
screen_name[statuses_count == max(statuses_count[party == "A"])]
creation_date <- creation_date %>% 
  as.character %>% as.Date(format = "%Y-%m-%d")
creation_year <- creation_date %>% format(format = "%Y") %>% as.numeric
creation_month <- creation_date %>% format(format = "%m") %>% as.numeric
detailed_creation_year <- creation_year + (creation_month / 12)

boxplot(
  detailed_creation_year ~ party, 
  main = "Creation Year of Account by Party",
  xlab = "Party",
  ylab = "Year When Account Was Created",
  col = c(afd_blue, cdu_orange, fdp_yellow, greens_green, left_purple, spd_red), 
  ylim = c(2008, 2019.7)
)
abline(h = 2013 + (31 + 6) / 365, lty = "dashed")
abline(h = c(
  2013 + 264 / 365,
  2017 + 266 / 365,
  2009 + 169 / 365
), lty = "dotted")
legend(
  "topright", 
  legend = c("AfD founded", "elections"), 
  lty = c(2, 3),
  cex = 0.75
)

sum(statuses_count)
# meiste AfD-Politiker nach Gründung --> keine privaten Accounts
# Grüne und FDPler sind early adopter
# neue Accounts von FDP und SPD strecken sich bis nach 2013 --> wegen schlechter Wahlergebnisse?

heatmap(
  cor(cbind(favorites_count, followers_count, friends_count, listed_count, statuses_count, detailed_creation_year)),
  keep.dendro = TRUE
)