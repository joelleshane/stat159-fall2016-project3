# function to calculate unemployment rate

unemployment_six_years <- function(dataset) {
  sub <- subset(dataset, is.na(dataset$COUNT_NWNE_P6) != TRUE & is.na(dataset$COUNT_WNE_P6) != TRUE)
  NW <- as.vector(sub$COUNT_NWNE_P6)
  W <- as.vector(sub$COUNT_WNE_P6)
  tot <- NW + W 
  return (NW / tot) }
 