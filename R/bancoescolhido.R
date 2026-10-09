install.packages("devtools")
library("devtools")

devtools::install_github("jfieberg/Data4Ecologists")
library(Data4Ecologists)

data(package = "Data4Ecologists")

help("Fish_Mercury", package = "Data4Ecologists")

dados_fm <- Fish_Mercury

str(dados_fm)
table(dados_fm$species)
table(dados_fm$state, dados_fm$species)
