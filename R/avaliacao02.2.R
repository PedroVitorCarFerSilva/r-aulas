#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# Avaliação: exploração e manipulação de dados com dplyr
# Nome completo: Pedro Vitor Carvalho Ferreira da Silva
# Banco de dados escolhido: Fish_Mercury
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 1. Carregamento dos pacotes e dos dados
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
library("devtools")
library(Data4Ecologists)
dados <- Fish_Mercury
library(dplyr)

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 2. Análise inicial do banco de dados
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
str(dados)
# Há 378 registros com quatro variáveis cada, sendo que estas 
# se referem à espécie (fator), comprimento (numérico), con-
# centração de mercúrio (numérico) e estado (fator).

table(dados$species)
# Há seis espécies amostradas, as mais expressivas são small-
# mouth bass (98) e channel catfish (95), enquanto brook trout
# (34) e white sucker (40) são as menos expressivas.

table(dados$state) 
# São 45 estados num total e há vários estados com baixo núme- 
# ro de amostras, como AR, MS e NM.

hist(dados$length, breaks = 20)
boxplot(dados$length)
summary(dados$length)
# A maioria dos peixes se encontra na faixa entre 20 e 45 cen-
# tímetros, apresentando uma distribuição normal com mediana 
# de 32,05 cm e média de 33,72 cm. São três outliers quando o 
# FIQ = 1,5.

hist(dados$Hg, breaks = 16)
boxplot(dados$Hg, range = 3)
summary(dados$Hg)
# A maioria dos peixes apresenta uma concentração de mercúrio 
# inferior a 0.4 mg/kg, apresentando uma distribuição normal 
# com mediana de 0.1295 ppm e média de 0.19135 ppm. Há diver-
# sos outliers com FIQ = 1,5, então foi alterado para FIQ = 3, 
# o que mostrou oito far outliers.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 3. Modificações para facilitar leitura e análise
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

dados <- dados %>%
  rename(espécie = species,
         comprimento = length,
         mercúrio = Hg,
         estado = state)
# As variáveis foram renomeadas para português.

dados <- dados %>%
  mutate(espécie = ifelse(
    espécie == "channel catfish", "Ictalurus punctatus",
    ifelse(espécie == "smallmouth bass", "Micropterus dolomieu",
    ifelse(espécie == "largemouth bass", "Micropterus nigricans",
    ifelse(espécie == "brown trout", "Salmo trutta",
    ifelse(espécie == "white sucker", "Catostomus commersonii",
    "Salvelinus fontinalis")))))) # brook trout
dados$espécie <- factor(dados$espécie)
# Espécies renomeadas para a nomenclatura científica.

dados <- dados %>%
  mutate(comprimento = comprimento/10)
# Altera comprimento de milímetros para centímetros.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 4. Análise dos outliers no comprimento e mercúrio
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

dados <- dados %>%
  arrange(desc(comprimento), mercúrio)
# Os dados foram ordenados por comprimento em ordem decrescen-
# te e por concentração de mercúrio em ordem crescente.

head(dados)
tail(dados)
# Com isso, é possível visualizar os outliers no tamanho. Por
# conta de provável erro de digitação, um peixe foi registrado 
# com 1,6 cm. Já os dois outros outliers parecem condizentes
# com o banco, apesar dos valores extremos, um com 75,9 cm e 
# outro com 67,9 cm.

dados <- dados %>%
  arrange(desc(mercúrio))
# Agora os dados foram reordenados por concentração de mercú-
# rio em ordem decrescente.

head(dados, 10)
tail(dados)
# Assim é possível visualizar os outliers mercúrio. Dentre os
# oito outliers todos estão acima do bigode, não abaixo. Des-
# tes, o segundo maior está acima do valor do terceiro por uma
# margem larga (0.341 mg/kg), o que pode indicar erro no re-
# gistro dos dados, porém, dentre os outliers, o com maior va-
# lor de concentração de mercúrio apresenta um comprimento no-
# tavelmente menor, reenforçando a hipótese do erro de regis-
# tro neste.

plot(dados$comprimento, dados$mercúrio)
cor.test(dados$comprimento, dados$mercúrio, method = "spearman")
# Por meio do teste de Spearman é possível comprovar a corre-
# lação positiva entre comprimento e dados, pois o valor p é
# menor que 0,05 e o coeficiente de correlação é positivo, a-
# pesar de fraca intensidade (rho = 0,302).

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 5. Remoção dos outliers mais destoantes
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

dados <- dados %>%
  mutate(razão = mercúrio / comprimento) %>%
  arrange(desc(razão))
boxplot(dados$razão, range = 3)
head(dados)
# Por meio da criação de uma variável que aponta a razão entre
# tamanho e concentração de mercúrio é possível identificar os
# dois outliers mais extremos, os quais condizem com os apon-
# tados anteriormente (o que possui comprimento de 1,6 cm e o 
# que possui concentração de mercúrio de 1,4 mg/kg).

dados <- dados %>%
  filter(razão < 0.04) %>%
  select(!razão)
# Os dados mais absurdos foram removidos com base na razão e a
# coluna da razão foi removida do banco de dados. Ambos os ob-
# jetos removidos foram coletados no estado MI (Michigan) e as
# suas espécies são, respectivamente, Salvelinus fontinalis e
# Micropterus dolomieu. Agora sobraram 376 objetos no banco.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# 6. Segunda análise do banco e conclusões
#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

dados %>%
  group_by(espécie) %>%
  summarise(mediana_cm = median(comprimento, na.rm=T),
            mediana_hg = median(mercúrio, na.rm=T)) %>%
  arrange(mediana_hg)
boxplot(dados_c$mercúrio~dados_c$espécie)
boxplot(dados_c$comprimento~dados_c$espécie)
# As espécies com maior mediana de tamanho não necessáriamente
# são as que mais acumulam mercúrio. Ictalurus punctatus, por
# exemplo, apresenta a maior mediana de tamanho e a mediana da
# concentração de mercúrio é a terceira menor. As espécies que
# apresentam uma maior concentração de mercúrio por uma margem 
# larga (0,1212 mg/kg) pertencem ao gênero Micropterus, o que
# aponta para uma influência dos hábitos de vida da espécie na 
# concentração média de mercúrio, pois esse gênero é connheci-
# do por ser predador de topo.

dados_mn <- dados[dados$espécie == "Micropterus nigricans",]
plot(dados_mn$comprimento, 
     dados_mn$mercúrio)
cor.test(dados_mn$comprimento, 
         dados_mn$mercúrio, method = "spearman")
# A espécie Micropterus nigricans apresenta correlação positi-
# va entre comprimento e concentração de mercúrio.
# valor-p = 0.004251 < 0.05
# rho = 0.3582385

dados_md <- dados[dados$espécie == "Micropterus dolomieu",]
plot(dados_md$comprimento, 
     dados_md$mercúrio)
cor.test(dados_md$comprimento, 
         dados_md$mercúrio, method = "spearman")
# A espécie Micropterus dolomieu apresenta correlação positiva
# entre comprimento e concentração de mercúrio.
# valor-p = 6.297e-06 < 0.05
# rho = 0.4405754

dados_cc <- dados[dados$espécie == "Catostomus commersonii",]
plot(dados_cc$comprimento, 
     dados_cc$mercúrio)
cor.test(dados_cc$comprimento, 
         dados_cc$mercúrio, method = "spearman")
# A espécie Catostomus commersonii apresenta correlação posi-
# tiva entre comprimento e concentração de mercúrio.
# valor-p = 0.0021 < 0.05
# rho = 0.4721063

dados_ip <- dados[dados$espécie == "Ictalurus punctatus",]
plot(dados_ip$comprimento, 
     dados_ip$mercúrio)
cor.test(dados_ip$comprimento, 
         dados_ip$mercúrio, method = "spearman")
# A espécie Ictalurus punctatus apresenta correlação positiva
# entre comprimento e concentração de mercúrio.
# valor-p = 0.04657 < 0.05
# rho = 0.2047341 

dados_st <- dados[dados$espécie == "Salmo trutta",]
plot(dados_st$comprimento, 
     dados_st$mercúrio)
cor.test(dados_st$comprimento, 
         dados_st$mercúrio, method = "spearman")
# A espécie Salmo trutta nãp apresenta correlação entre o com-
# o comprimento e a concentração de mercúrio.
# valor-p = 0.1431 > 0.05
# rho = 0.2122666

dados_sf <- dados[dados$espécie == "Salvelinus fontinalis",]
plot(dados_sf$comprimento, 
     dados_sf$mercúrio)
cor.test(dados_sf$comprimento, 
         dados_sf$mercúrio, method = "spearman")
# A espécie Salvelinus fontinalis nãp apresenta correlação en-
# tre o comprimento e a concentração de mercúrio.
# valor-p = 0.6159 > 0.05
# rho = 0.09065064 

# As quatro espécies com maior concentração de mercúrio tem a-
# presenta correlação positiva entre comprimento e mercúrio 
# com base no teste de Spearman dos dados do banco, enquanto 
# as espécies com menor concentração não apresentam isso. Isso
# reforça a hipótese da bioacumulação com o decorrer da vida 
# em espécies com hábito de predador de topo, enquanto espéci-
# es em níveis mais baixos da cadeia trófica demonstram menor
# acumulação de mercúrio. Os números médios na acumulação nos
# peixes detritívoros (Catostomus commersonii) e onívoros de 
# fundo (Ictalurus punctatus) pode ser explicada pela presença
# de bactérias anaeróbicas que convertem o mercúrio em metil-
# mercúrio no sedimento ao fundo dos corpos d'água.

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~