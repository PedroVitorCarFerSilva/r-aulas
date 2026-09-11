##########
# AULA 5 #
##########

# Data.frames: multidimensionais

ano <- c(2020:2026)
local <- c("Mossoró","Natal","Caicó","Natal","Natal","Caicó","Assú")
n_arvores <- c(3000,5300,2200,7500,1600,3100,8000)
n_buracos <- c(540, 278, 250, 437, 623, 608, 914)
qualidade_ar <- c("Boa", "Ruim", "Ruim", "Boa", "Ruim", "Boa", "Boa")
qualidade_vida <- c("1", "2", "3", "4", "3", "2", "1")

# Quantitativa (numérica, cálculo): num, int
# Qualitativa (não numérica): chr -> pode ser convertido para factor, com levels
## Diferença de factor para character (importante): factor considera string repetidas como a mesma, mas chr não

?factor
f_local <- factor(local) # nesse caso específico factor() e as.factor() funcionam igual, mas são diferentes
f_qualidade_ar <- as.factor(qualidade_ar)
f_qualidade_vida <- factor(qualidade_vida)

?data.frame
# Duas formas diferentes de criar data.frames:
dados <- data.frame(ano, f_local, n_arvores, n_buracos, f_qualidade_ar, f_qualidade_vida)
dados2 <- data.frame(Year = ano, City = local, Trees = n_arvores, Holes = n_buracos, Air_quality = f_qualidade_ar, Life_quality = f_qualidade_vida)
# Sifrão ($) no R representa a possibilidade de trabalhar na coluna
dados2$Year
dados2$City
# Data.frames com dados de outro Data.frame
dados3 <- data.frame(Year = dados2$Year, City = dados2$City)
dados3 <- dados2[,c(1,2)]
dados4 <- c(dados2$Year, dados2$City) # Errado, cria vetor