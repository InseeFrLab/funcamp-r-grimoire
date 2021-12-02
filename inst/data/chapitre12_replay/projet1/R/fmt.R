


#' @title fmt
#' @author M. Martin, \email{martin@@insee.fr}
#' @description Formate un nombre
#' @details La fonction formate avec
#' le nombre de decimales specifie, 
#' la virgule pour distinguer unites et decimales, 
#' l'espace comme separateur de milliers. 
#' @section Emploie :
#' La fonction \url{https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/format}
#' @section Warning :
#' N'utilise pas de notation scientifique
#' @param x un nombre
#' @param decimales un entier, le nombre de decimales
#' @return Le nombre formate.
#' @import dplyr
#' @examples
#' fmt2Decimales(100, 2)
#' fmt2Decimales(1234.56789, 2)
#' @family fonctions pour formater
#' @seealso \url{https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/print} pour afficher dans la console
#' @references \url{https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/format} la fonction format
fmt <- function(x, decimales) {

  format(x,                   
                             
         decimal.mark = ",",  
         digits=0, nsmall=decimales,  
         big.mark = " ",      
         scientific = FALSE   
  )      
  
}


#' @title fmt1Decimale
#' @author M. Martin, \email{martin@@insee.fr}
#' @description Formate un nombre
#' @details La fonction formate avec
#' une decimale, 
#' la virgule pour distinguer unites et decimales, 
#' l'espace comme separateur de milliers. 
#' @section Emploie :
#' Les fonctions \code{\link{fmt}} et \url{https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/format}
#' @section Warning :
#' N'utilise pas de notation scientifique
#' @param x un nombre
#' @return Le nombre formate
#' @import dplyr
#' @examples
#' fmt1Decimale(100)
#' fmt1Decimale(1234.56789)
#' @family fonctions pour formater
#' @seealso \url{https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/print} pour afficher dans la console
#' @references \url{https://www.rdocumentation.org/packages/base/versions/3.6.2/topics/format} la fonction format
fmt1Decimale <- function(x) {

  fmt(x, 1)
}