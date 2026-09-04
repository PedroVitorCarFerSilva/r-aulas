##########
# AULA 4 #
##########

# Matriz
## Escalar -> Apenas uma informação, quantitativa ou qualitativa.
## Vector -> "Matriz" unidimensional, com apenas uma linha ou coluna. Ex.: [2, 4, 5, 1, 9, 0, 0, 3, 6]
## Matriz -> Formada por linhas e colunas. [7, 0]
###                                        [2, 4]
## Dataframe -> Matriz "especial", na qual os variáveis podem ser de categorias diferentes, não apenas de números.

# Legal usar <- para definir variáveis e = para argumentos

fulvio <- 2026 
freire <- 2236
fulvio
freire
?print(freire)

fulvio + freire

if (fulvio == freire){
  message("Hello world!")
} else {
  print(fulvio + freire)
  print(fulvio - freire)
  print(fulvio * freire)
  print(fulvio / freire)
}

# Concatenar com função c() -> Une informações em um único objeto
freud <- c(fulvio, freire, 2099, 2670)
# Posição matricial
freud[1]
freud[1:3]
freud[c(1,3)]
# Subtrair informações
floid <- freud[-3]
floid <- freud[c(-1,-3)]
floid

# Matriz

recurso <- 1:1200

# byrow quando TRUE faz ser por linha e quando FALSE por coluna
notas <- matrix(data = recurso, nrow = 50, 24, T)
notas <- matrix(data = recurso, nrow = 50, 24, F)



