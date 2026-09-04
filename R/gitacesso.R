#################
# GITHUB ACESSO #
#################

install.packages("usethis")
credentials::set_github_pat()
gitcreds::gitcreds_get()

# Clonar:
## $ git clone https://github.com/PedroVitorCarFerSilva/r-aulas.git

# Push:
## $ git status
## $ git add .
## $ commit -m "Alterações"
## $ push -u origin main