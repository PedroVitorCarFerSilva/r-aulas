# Exercícios práticos sobre o pacote dplyr
# Aluno: Pedro Vitor Carvalho Ferreira da Silva

data <- iris

# Questões

#----------------------------------------------------#

## Questão 01:

str(data)

### O banco de dados possui uma dimensão de cinco va-
### riáveis/colunas e 150 objetos/linhas.

#----------------------------------------------------#

## Questão 02:

### Dentre as variáveis estão quatro numéricas 
### (Sepal.Lenght, Sepal.Width, Petal.Lenght, e 
### Petal.Width), além de uma variável em fator 
### (Species).

#----------------------------------------------------#

## Questão 03:

### A)
data[data$Sepal.Length >= 5, ]

### B)
data[data$Petal.Length < median(data$Petal.Length), ]

### C)
data[data$Sepal.Width <= 3 & data$Petal.Width > 2, ]

#----------------------------------------------------#

## Questão 04:

### A)
data_f <- data %>%
  filter(Species == "versicolor")
### A dimensão do banco de dados filtrado é de 50 ob-
### jetos/linhas.

### B)
data_f <- data %>%
  filter(Species != "versicolor" &
           Petal.Width > 0.3)
### A dimensão do banco de dados filtrado é de 59 ob-
### jetos/linhas.

#----------------------------------------------------#

## Questão 05:

data_s <- data %>%
  select(!c(Petal.Length, Petal.Width)) %>%
  arrange(desc(Sepal.Length))

head(data_s)

### A)
### O comprimento da maior sépala é 7.9 mm.

### B) 
### A flor que corresponde a esse resultado pertence
### à espécie "virginica".

#----------------------------------------------------#

## Questão 06:

data_m <- data %>%
  mutate(Petal.Area = Petal.Length * Petal.Width)

### A)
summary(data_m)
### O menor e o maior valor de área de pétala são,
### respectivamente, 0.11 mm^2 e 15.87 mm^2.

### B)
boxplot(data_m$Petal.Area~data_m$Species)
### As espécies que possuem, em mediana, menor e maior
### áreas de pétala são, respectivamente, "setosa" e 
### "virginica".

#----------------------------------------------------#

## Questão 07:

summary(data_m$Petal.Area)

data_m <- data_m %>%
  mutate(Plant.Stage = 
           ifelse(Petal.Area <= 0.42, 
                  "Plantula",
                  ifelse(Petal.Area >= 9.69, 
                         "Reprodutivo", 
                         "Vegetativo"
                         )
                  )
         ) 

#----------------------------------------------------#

## Questão 08:

dados <- data %>%
  rename(Comprimento_da_sépala = Sepal.Length,
         Largura_da_sépala = Sepal.Width,
         Comprimento_da_pétala = Petal.Length,
         Largura_da_pétala = Petal.Width,
         Espécie = Species)
  
#----------------------------------------------------#

## Questão 09:

### A)
data %>%
  group_by(Species) %>%
  summarise(Largura_media = mean(Petal.Width, na.rm=T)) %>%
  arrange(desc(Largura_media))
### As espécies com maior e menor larguras médias de 
### pétala são, respectivamente, "virginica" e 
### "setosa".

### B)
table(data$Species)
### Foram medidas 50 flores em cada espécie.

#----------------------------------------------------#

## Questão 10:

library(tidyr)

data_l <- data %>%
  pivot_longer(cols = Sepal.Length:Petal.Width, 
               names_to = "Var_morfometrica",
               values_to = "Valor_mm")
