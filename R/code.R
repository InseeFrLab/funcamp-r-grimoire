#' @import magrittr
#' @import stringr
#' @import purrr
get_header <- function(file){
  suppressWarnings(
  base <- file %>%    readLines() # on ouvre le fihcier ligne a ligne
  )
  pos <- base %>%
    str_detect("---") %>%
    which() # on detecte les balise d'ouverture et fermeture

  if (length(pos)>=2){return(base[pos[1]:pos[2]])} # on retourne le header

  return("")
}

is_rmd_shiny <- function(header,balise="runtime:shiny"){

  res <-  header %>%
    map_chr(~str_remove_all(.x,"\\s")) %>%
    str_detect(balise) %>% sum()
  res >= 1
}

#' liste tous les Rmd candidats au deploiement contenus dans le package
#' avec runtime:shiny ou runtime:shiny_prerendered
#' @param pattern pattern des fichiers a proposer
#'
#' @export
tous_les_programmes <- function(pattern = "*.Rmd$"){
tous_les_rmd<-list.files(system.file("learnr", package = "funcampR"),
           all.files = TRUE,full.names = TRUE,
           include.dirs = FALSE,no.. = FALSE,
           recursive = TRUE,
           pattern = pattern
           )
a_garder <- tous_les_rmd %>%
  map(get_header) %>%
  map_lgl(is_rmd_shiny)
tous_les_rmd[a_garder]
}

#' Lance un support learnr
#'
#' @param file file to deploy
#' @param port port to use
#'
#' @export
#'
launch_learn <- function(file=sample(tous_les_programmes(),1),port=3838,host='0.0.0.0'){
  message(file)
rmarkdown::run(file = file,
  shiny_args = list(port = port,host=host,launch.browser=FALSE))
}
