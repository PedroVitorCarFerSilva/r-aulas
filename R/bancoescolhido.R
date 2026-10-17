install.packages("devtools")
library("devtools")

devtools::install_github("jfieberg/Data4Ecologists")
library(Data4Ecologists)

data(package = "Data4Ecologists")

help("Fish_Mercury", package = "Data4Ecologists")

dados_fm <- Fish_Mercury

str(dados_fm)
table(dados_fm$species)
levels(dados_fm$state)
summary(dados_fm)

hist(dados_fm$length)
hist(dados_fm$Hg)

boxplot(dados_fm$length~dados_fm$species)
boxplot(dados_fm$Hg~dados_fm$species)

dados_fm <- dados_fm %>%
  arrange(length)
head(dados_fm)

dados_fm %>%
  group_by(species) %>%
  summarise(mean_length = mean(length, na.rm=T))

