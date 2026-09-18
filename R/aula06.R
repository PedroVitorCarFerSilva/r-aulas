## tipos de dados ##
# Dados numéricos
x <- 6.5
x
# Dados inteiros
y <- 3
x + y
y2 <- 11:20
y2
# Dados de caracteres
nome <- "UFRN"
nome
# Dados lógicos (TRUE, FALSE e NA)
a <- TRUE
a
# Uso do comando class

# Diferença entre character e factor
a <- c("macho", "fêmea", "indefinido", "macho", "indefinido", "fêmea")
a <- factor(a)
a
# Mudar a ordem dos níveis (levels)
levels(a)
a2 <- factor(a, levels = c("macho", "fêmea", "indefinido"))
a2

mes <- c(rep("Jan",6),rep("Fev",6),rep("Mar",6),rep("Abr",6),rep("Mai",6),rep("Jun",6),rep("Jul",6),rep("Ago",6),rep("Set",6),rep("Out",6),rep("Nov",6), rep("Dez",6))
mes

data <- sample(80:100, 72, replace=TRUE)
data

data2 <- data.frame(Mês = mes, Peso = data)
data2$Mês <- as.factor(data2$Mês)
str(data2)
data2$Mês
boxplot(data2$Peso~data2$Mês)
levels(data2$Mês)

data2$Mês <- factor(data2$Mês, levels = c("Jan","Fev","Mar","Abr","Mai","Jun","Jul","Ago","Set","Out","Nov","Dez"))
boxplot(data2$Peso~data2$Mês)
levels(data2$Mês)

attach(data2)
?attach
Mês
boxplot(Peso~Mês)
detach(data2)

# Números como caracteres ou fatores
z <- 1:10
z
class(z)
z2 <- as.character(z)
z2
class(z2)
z3 <- factor(z2, levels = c("10","9","8","7","6","5","4","3","2","1"))
z3

# Vetor de dados
m <- c(1,2,3,4,5,6,7,8,9,10)
# O uso do colchete
m2 <- m[3:6]
m3 <- m[8:10]
m4 <- m[c(1,3,5,7,9)]
# Matriz de dados
m <- matrix(m, nrow = 1)
m2 <- matrix(m, nrow = 2)
m3 <- matrix(data=c(-3,2,893,0.17), nrow=2, ncol=2)
m4 <- matrix(data=c(-3,2,893,0.17), nrow=2, ncol=2, byrow = TRUE)
m3
m4
# O uso do colchete
m3
m4 <- m3[1,]
m4
m5 <- m3[,2]
m5
m6 <- m3[2,2]
m6
# Array
c <- array(1:12, dim = c(2, 2, 3))
c

# data.frame
níveis <- c("M","F","F","M","M","F")
sim <- rnorm(6, mean = 20)
sim
hist(sim)
dados <- data.frame(sexo = níveis, peso = sim)
dados
names(dados)
names(dados) <- c("Sexo", "Peso")
dados

dados2 <- data.frame(Sexo = c("M","F","F","M","M","F"), Peso = rnorm(6, mean = 20))
dados2

Altura <- rnorm(6, mean = 10)
dados2 <- cbind(dados, Altura)
dados3 <- rbind(dados2,list("M",16,10))
dados3

## Comandos interessantes ##

# Comando subset
dados4 <- subset(dados3, Sexo == "M")
dados4
subset(dados3, Peso < 19)
subset(dados3, Peso < 19, select = - Sexo)
subset(dados3, Peso < 19, select = Sexo:Peso)
subset(dados3, Peso < 19, select = c(Sexo,Altura))

# Comando rep (repetição)
rep(x=1,times=4)

rep(x=c(3,62,8.3),times=3)

rep(x=c(3,62,8.3),each=2)

rep(x=c(3,62,8.3),times=3,each=2)

# Operação em matrizes
A <- rbind(c(2,5,2),c(6,1,4))
A
t(A) #Matriz transposta

A <- diag(x=3) # Criação de uma matriz identidade
A

A <- matrix(seq(1:10), 5, 2)
A
a <- 2
A2 <- a*A #Multiplicação da mariz por um escalar
A2

A2 - A #Subtração de matrizes

A <- rbind(c(2,5,2),c(6,1,4))
dim(A)
B <- cbind(c(3,-1,1),c(-3,1,5))
dim(B)
C <- A%*%B #Multiplicação de matrizes
C

solve(C) #Matriz inversa
C%*%solve(C) #Comprovação da solução

# Concatenar dados
dados3 <- data.frame(Sexo = c("M","F","F","M","M","F"), Local = c("1","1","1","2","2","2"), Peso = rnorm(6, mean = 20))
dados3
S.L <- paste(dados3$Sexo, dados3$Local)
S.L
dados4 <- cbind(dados3, S.L)
dados4

# Continuação do exercício rownames e colnames
rownames(dados4) <- c("p1", "p2", "p3", "p4", "p5", "p6")
dados4
colnames(dados4) <- c("Sex", "Loc", "P", "sl")
dados4

# list
list_2 <- list(colours = c("black", "yellow", "orange"), evaluation = c(TRUE, TRUE, FALSE, TRUE, FALSE, FALSE), time = matrix(1:6, nrow = 3))
list_2
list_2$colours
list_2$evaluation
list_2$time
list_2[["colours"]]

#------ ESTUDAR ATE AQUI PRA PROVA ------#

# Outra forma de criar subgrupos, a partir de um objeto criado:
# Prestem atenção na vírgula dentro dos colchetes
dados4[dados4$P >= 20, ] # Linhas maiores ou iguais a 20 (P)
dados4[dados4$P <= 20, ] # Inverso
dados4[dados4$Sex == "M", ] # Linhas com Sex = M
dados4[dados4$Sex != "M", ] # Linhas com Sex diferentes M

Sub_dados4 <- dados4[dados4$P >= 20 & dados4$Loc == "2",]
Sub_dados4

Sub_dados4 <- dados4[dados4$P >= 20 | dados4$Loc == "2",]
Sub_dados4

# Ordenando com função order
dados5 <- dados4[order(dados4$sl), ]
dados5

dados5 <- dados4[order(dados4$sl, -dados4$P), ] # Sinal - decrescente
dados5

# Função merge (mesclar)
taxa <- data.frame(GENUS = c("Patella", "Littorina", "Halichondria", "Semibalanus"), species = c("vulgata", "littoria", "panacea", "balanoides"), family = c("patellidae", "Littorinidae", "Halichondriidae", "Archaeobalanidae"))
taxa

zone <- data.frame(genus = c("Laminaria", "Halichondria", "Xanthoria", "Littorina", "Semibalanus", "Fucus"), species = c("digitata", "panacea", "parietina", "littoria", "balanoides", "serratus"), zone = c( "v_low", "low", "v_high", "low_mid", "high", "low_mid"))
zone

taxa_zone <- merge(x = taxa, y = zone)
taxa_zone

caranguejo <- read.table("totaldata.txt", header = TRUE)
str(caranguejo)
table(caranguejo$acribarius, caranguejo$cdanae) # Tabela contagem
xtabs(~ transect + period, data = caranguejo) # T contingência
xtabs(~ transect + period + month, data = caranguejo)

# Cálculos de estatística descritiva
tapply(caranguejo$BT, caranguejo$month, mean)
tapply(caranguejo$BT, caranguejo$month, sd)
cara1 <- aggregate(caranguejo[, 4:6], by = list(Month = caranguejo$month), FUN = mean)
cara2 <- aggregate(caranguejo[, 4:6], by = list(Month = caranguejo$month, Period = caranguejo$period), FUN = mean)

# Exportando dados
write.table(cara1, file = "planilha1.txt", col.names = TRUE, row.names = FALSE, sep = "\t")

library(writexl)
write_xlsx(cara2,"planilha2.xlsx")

