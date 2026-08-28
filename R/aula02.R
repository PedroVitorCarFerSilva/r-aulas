##########
# AULA 2 #
##########

# A interrogação dá informações sobre a função
?dir.create
# Criar diretórios
dir.create("R")
dir.create("Dados")
dir.create("Figuras")
dir.create("Relatorios")
# Criar subpastas
dir.create("Dados/Brutos")
dir.create("Dados/Limpos")
# Acessar diretorio de trabalo
getwd()
# Definir diretório
setwd("Dados/Limpos")
setwd("../..")
setwd("..")
# Definir diretório do projeto
projeto_dir <- "C:/Users/aluno/Documents/r-aulas"
setwd(projeto_dir)
# Importar dados em csv
?read.csv
campo_csv <- read.csv(file = "Dados/Limpos/dados_campo.csv")
head(campo_csv)
tail(campo_csv)
# Importar dados em xlsx
install.packages("readxl")
library(readxl)
?read_xlsx
campo_xl <- read_xlsx(path = "Dados/Limpos/dados_campo.xlsx")
# Criar dataframe e salvar arquivo como .rds ou .RData
dados_fake <- data.frame("Amostra" = 1:9,
                         "Abundancia" = rnorm(n = 9, mean = 5, sd = 2))
dados_fake
?saveRDS
saveRDS(object = dados_fake,
        file = "Dados/Limpos/dados_fake.rds")
saveRDS(object = dados_fake,
        file = "Dados/Limpos/dados_fake.RData")
# Importar .rds
dados_importados <- readRDS("Dados/Limpos/dados_fake.rds")