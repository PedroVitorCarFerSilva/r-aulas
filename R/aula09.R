###########################################
#                                         #
#    Transformando formato dos dados      #
#                  &                      #
#           Dados relacionais             #
#                                         #
###########################################

# Marie-Christine Rufener 
# Setembro, 2026


# O script visa introduzir as principais funções que fazem parte do pacote dplyr.
# Tópicos abordados na aula prática:


# 1) Tranformando o formato dos dados (longo/largo)
# 2) Bancos de dados relacionais


#><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>


#~~~~~~~~~~~~~~~~~~~~~~~~
# Carregando os pacotes
#~~~~~~~~~~~~~~~~~~~~~~~~
library(dplyr)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Definindo o diretório base
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
setwd("~/OneDrive/Arbeit/Lectures_and_Talks/UFRN/Lectures/Undergraduation/BEZ0145-Introducao_R/Aulas/2026/Semestre_02/Aula_dplyr/")


#><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1) Carregando o banco de dados
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 1.1) Dados das pescarias
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dados_pescaria <- read.csv2("Dados/dados_pescaria.csv")
head(dados_pescaria)


# 1.2) Dados biológicos
#~~~~~~~~~~~~~~~~~~~~~~~~
dados_bio <- read.csv2("Dados/dados_biologicos.csv")
head(dados_bio)



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2) Transformando os dados
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# 2.1) Transformando do largo para longo
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dados_longo <- dados_pescaria %>%
               pivot_longer(cols = Thunnus_albacares:Thunnus_atlanticus, #Seleciona as colunas das espécies
                            names_to = "Especie", #Nome da nova coluna que guardará os nomes das espécies
                            values_to = "Abundancia") #Nome da nova coluna que guardará os valores numéricos associado a cada espécie

head(dados_longo)



# 2.2) Transformando do longo para largo
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
dados_largo <- dados_longo %>%
                pivot_wider(names_from = "Especie",
                            values_from = 'Abundancia')

head(dados_largo)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3) Banco de dados relacionais
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~


length(unique(dados_bio$Pescaria_ID))
length(unique(dados_pescaria$Pescaria_ID))


### Transformando a coluna 'chave' para fator
# Esta é a coluna em comum aos dois bancos de dados e será usada para juntar os dados
# A informação precisa ser transformada para uma variável 'fator'

class(dados_bio$Pescaria_ID)
class(dados_pescaria$Pescaria_ID)


dados_bio$Pescaria_ID <- as.factor(dados_bio$Pescaria_ID)
dados_pescaria$Pescaria_ID <- as.factor(dados_pescaria$Pescaria_ID)




### 3.8.2) Left-join ###
#~~~~~~~~~~~~~~~~~~~~~~#
# E.g., agregar as informações long/lat aos dados biológicos
# Mantém TODAS as linhas da tabela da esquerda (dados biológicos)
# Adiciona as colunas da direita (dados_pescaria) onde houver correspondência

dados_bio2 <- left_join(dados_bio, dados_pescaria, by = "Pescaria_ID")
dim(dados_bio)
dim(dados_bio2)


### 3.8.3) Full join ###
#~~~~~~~~~~~~~~~~~~~~~~#
# Mantém todas as linhas de AMBOS os dados
dados_full <- full_join(dados_bio, dados_pescaria, by = "Pescaria_ID")
head(dados_full)



### 3.8.4) Inner join ###
#~~~~~~~~~~~~~~~~~~~~~~#
# Mantém apenas as linhas que possuem correspondência em AMBOS os dadis
dados_full2 <- inner_join(dados_bio, dados_pescaria, by = "Pescaria_ID")
head(dados_full2)
