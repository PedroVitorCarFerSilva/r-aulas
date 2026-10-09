#########################################
#                                       #
#    Tratamento de dados com dplyr      #
#                                       #
#########################################

# Marie-Christine Rufener 
# Setembro, 2026


# O script visa introduzir as principais funções que fazem parte do pacote dplyr.
# Tópicos abordados na aula prática:


# 1) Filtragem de dados
# 2) Seleção de dados
# 3) Oredenação de dados
# 4) Renomeando colunas
# 5) Criando/modificando colunas
# 6) Agrupando os dados


#><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>


#~~~~~~~~~~~~~~~~~~~~~~~~
# Carregando os pacotes
#~~~~~~~~~~~~~~~~~~~~~~~~
install.packages("dplyr")
library(dplyr)

?dplyr



#~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Definindo o diretório base
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Define o diretório de trabalho, i.e., o local
# onde são guardados os dados, scripts, do projeto em questão.

setwd("C:/Users/aluno/Documents/r-aulas")


#><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><><>


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1) Carregando o banco de dados
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

# Como exemplo, usaremos o banco de dados dos pinguins de palmer.
# Dados baixados de: https://www.kaggle.com/datasets/samybaladram/palmers-penguin-dataset-extended?resource=download

# Os dados foram coletados no Arquipélago Palmer, próximo à Antártida, ao longo dos anos 2021-2025. 
# Esses dados fornecem informações sobre três espécies de pinguins e inclui variáveis biológicas,
# como dimensões do bico e massa corporal. Além disso, o banco de dados
# conta com variáveis adicionais, como dieta, ano de observação, estágio de vida e 
# indicadores de saúde. Esse conjunto de informação permitem uma compreensão 
# mais detalhada da biologia e ecologia dos pinguins.

dados <- read.csv("Dados/Brutos/palmerpenguins.csv")



#~~~~~~~~~~~~~~~~~~~~~~~~
# 2) Explorando os dados
#~~~~~~~~~~~~~~~~~~~~~~~~


# 2.1) Estrutura geral
#~~~~~~~~~~~~~~~~~~~~~~

### Visualizador dos dados tipo excel ###
View(dados)


## Primeiras 6 linhas 
head(dados)


## Últimas 6 linhas 
tail(dados)


## Estrutura dos dados
str(dados)


## Resumo geral dos dados
summary(dados)
summary(dados$bill_length_mm)



#~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3) Manipulando os dados
#~~~~~~~~~~~~~~~~~~~~~~~~~~


# 3.1) Filtrando os dados
#~~~~~~~~~~~~~~~~~~~~~~~~~


### 3.1.1) Baseado em variáveis numéricas ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

summary(dados$body_mass_g)

## Valores maiores ou menores que...
dados_f <- dados %>%
           filter(body_mass_g <= 4835)

#dados_f <- dados[dados$body_mass_g <= 4835, ] #Função base


summary(dados_f$body_mass_g)



## Valores em um intervalo
dados_f <- dados %>%
           filter(body_mass_g >= 3884 & body_mass_g <= 5622)


#dados_f <- dados[dados$body_mass_g >= 3884 & dados$body_mass_g <= 5622, ] #Função base


summary(dados_f$body_mass_g)



### 3.1.2) Baseado em variáveis categóricas/character ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
table(dados$species)


## Filtrando apenas uma categoria
dados_f <- dados %>%
           filter(species == "Adelie")

#dados_f <- dados[dados$species == "Adelie", ] #Função base


## Filtrando mais de uma categoria
dados_f <- dados %>%
  filter(species %in% c("Adelie", "Chinstrap"))

#dados_f <- dados[dados$species %in% c("Adelie", "Chinstrap"), ] #Função base


## Filtrando todas as categorias, menos a que está sendo especificada
dados_f <- dados %>%
           filter(!(species == "Adelie"))

table(dados_f$species)

#dados_f <- dados[!(dados$species == "Adelie"), ] #Função base




### 3.1.3) Baseado em variáveis de diferentes tipos ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

dados_f <- dados %>%
           filter(species == "Adelie", body_mass_g >= 4835, sex == "female")


#dados_f <- dados[dados$species == "Adelie" & dados$body_mass_g >= 4835 & dados$sex == "female", ] #Função base



#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##################     DESAFIO     ##################

# Filtre os dados de modo que o dado final
# contenha apenas pinguins juvenis (life_stage)
# das ilhas Biosce e Torgensen (island) e com
# pesos maiores que 4000 g.

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

table(dados$life_stage)

table(dados$island)

head(dados)

dados_d <- dados %>%
  filter(life_stage == "juvenile" &
           island != "Dream" &
           body_mass_g > 4000)

summary(dados_d)

# 3.2) Selecionando as colunas
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
head(dados)
colnames(dados)


### 3.2.1) Colunas específicas ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

dados_s <- dados %>%
           select(species, life_stage, body_mass_g, health_metrics, year)
dim(dados_s)

#dados_s2 <- dados[, c("species", "life_stage")] #Função base


### 3.2.2) Colunas sequenciais ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
dados_s <- dados %>%
           select(species:diet)

#  dados_s2 <- dados[, 1:8] #Função base



### 3.2.3) Todas as colunas, menos a que está sendo especificada ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
dados_s <- dados %>%
  select(-c(bill_length_mm, bill_depth_mm))


#Função base
# COLNAMES <- colnames(dados)
# EXCLUDE <- c("bill_length_mm", "bill_depth_mm")
# KEEP <- setdiff(COLNAMES, EXCLUDE) ## intersect faz o oposto
# dados[, KEEP]


### 3.2.4) Seleção de variáveis por condição ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
dados_s <- dados %>% 
  select_if(is.numeric)


#dados_s2 <- dados[, sapply(dados, is.numeric)] #Função base




#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##################     DESAFIO     ##################

# Selecione apenas as colunas 'sex', 'health_metrics' & 'body_mass_g'.
# Na sequência, filtre apenas pinguins do sexo feminino
# (female) que estejam acima do peso (overweight).
# Salve esse banco de dados em um novo objeto.

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

dados_d <- dados %>%
  select(sex, health_metrics, body_mass_g) %>%
  filter(sex == "female" & health_metrics == "overweight")
  
summary(dados_d)

saveRDS(object = dados_d,
        file = "Dados/Limpos/dados_desafio.rds")

# 3.3) Ordenando os dados
#~~~~~~~~~~~~~~~~~~~~~~~~~

### 3.3.1) Ordenando por uma coluna específica ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
dados_o <- dados %>%
           #arrange(body_mass_g) #Em ordem crescente
           arrange(desc(body_mass_g)) #Em ordem decrescente

head(dados$body_mass_g)
head(dados_o$body_mass_g)


#dados_o2 <- dados[order(dados$body_mass_g),] # Função base



### 3.3.2) Ordenando por mais de uma coluna ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
dados_o <- dados %>%
           arrange(body_mass_g, bill_length_mm) 
           #arrange(body_mass_g, desc(bill_length_mm)) 




#>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>
##################     DESAFIO     ##################

# Use os dados do último desafio e ordene a coluna
# 'body_mass_g' por ordem decrescente de peso.
# Qual o peso da fêmea mais pesada?

#<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<<

dados_importados <- readRDS("Dados/Limpos/dados_desafio.rds")

dados_d <- dados_importados %>%
  arrange(desc(body_mass_g))

head(dados_d)

# 3.4) Criando/modificando colunas
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### 3.4.1) Criando uma nova coluna com base em coluna existente ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
dados_m <- dados %>% 
           mutate(body_mass_kg = body_mass_g / 1000)

cbind(dados_m$body_mass_g, dados_m$body_mass_kg)

#dados_m$body_mass_kg <- dados$body_mass_g / 1000 #Função base



## 3.4.2) Modificando uma coluna ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
table(dados$life_stage)

dados_m <- dados %>% 
           mutate(life_stage2 = ifelse(life_stage == 'adult', 'adult', 'sub-adult'))

table(dados_m$life_stage2)


# dados$life_stage <- ifelse(dados$life_stage  == 'adult', 'adult', 'sub-adult') #Função base

# dados$life_stage2 <- if(dadosdados$life_stage  == 'adult', "adulto")
#                      else("subadult")



### 3.4.3) Trocando o tipo de variável ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
str(dados)

FATORES <- c("species", "island", "sex", "diet", "life_stage", "health_metrics")

dados_m <- dados %>%
         mutate(across(FATORES, as.factor))


### alternativa
dados <- dados %>%
         mutate(across(where(is.character), as.factor))

str(dados)

# Função base
#dados[ , FATORES] <- lapply(dados[, FATORES], as.factor)

levels(dados$species)
nlevels(dados$species)


### 3.4.4) Modificando os níveis de uma variável fator ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
dados_m <- dados %>%
           mutate(sexo = ifelse(sex == 'female', "femea", "macho"),
                  dieta = ifelse(diet == "fish", "peixe",
                          ifelse(diet == "krill", "krill",
                          ifelse(diet == "parental", "parental", "lula"))))
           

#Função base 
# levels(dados_m$diet) <- c("peixe", "krill", "parental", "lula") #Renomando todos os níveis
# levels(dados_m$diet) 
# levels(dados_m$diet)[levels(dados_m$diet)=="squid"] <- "lula" #Renomando alguns níveis





# 3.5) Renomeando as colunas
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

### 3.5.1) Trocando para português ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
dados_r <- dados %>%
           rename(especie = species,
                  ilha = island,
                  comp_bico_mm = bill_length_mm,
                  prof_bico_mm = bill_depth_mm,
                  comp_nadadeira_mm = flipper_length_mm,
                  massa_corporal_g = body_mass_g,
                  sexo = sex,
                  dieta = diet,
                  estagio = life_stage,
                  estado_peso = health_metrics,
                  ano = year)

head(dados_r)

#colnames(dados)[1:3] <- c("especie", "ilha", "comp_bico_mm") #Funcao base





# 3.6) Agrupando os dados
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~


### 3.6.1) Calculando o peso médio por espécie de pinguim ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#

dados %>%
  group_by(species) %>%
  summarise(Peso_medio = mean(body_mass_g, na.rm=T))



### 3.6.2) Quantos pinguins há em cada categoria de peso? ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
dados %>%
  group_by(health_metrics) %>%
  #group_by(health_metrics, sex) %>%
  count()



### 3.6.3) Proporção por categoria ###
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~#
dados %>%
  group_by(health_metrics) %>%
  summarise(Contagem = n()) %>%
  mutate(Proporcao = Contagem/sum(Contagem))


