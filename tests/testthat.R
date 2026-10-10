# Point d'entrée des tests : testthat::test_dir("tests/testthat") depuis la
# racine du projet, ou Rscript tests/testthat.R
library(testthat)
test_dir("tests/testthat", stop_on_failure = TRUE)
