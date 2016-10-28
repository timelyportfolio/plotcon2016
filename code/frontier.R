library(plotly)
library(quantmod)
library(fPortfolio)
library(purrr)
library(pipeR)

tickers <- "BAMLCC0A0CMTRIV"
prices <- map(tickers, function(ticker){
  getSymbols(ticker, src="FRED", auto.assign=FALSE) %>>%
    na.omit()
})

prices[[2]] <- getSymbols('^GSPC', from="1950-01-01", auto.assign=FALSE)[,6]

returns_xts <- do.call(
  merge,
  map(
    prices,
    quantmod::monthlyReturn
  )
)
returns_xts[1,] <- 0
colnames(returns_xts) <- c("BofAMLCorp","SP500")

returns_xts %>>%
  na.omit() %>>%
  {.["1980::1990",]} %>>%
  as.timeSeries() %>>%
  portfolioFrontier() %>>%
  plot()

frontier <- returns_xts %>>%
  na.omit() %>>%
  {.["1980::1990",]} %>>%
  as.timeSeries() %>>%
  portfolioFrontier()

frontierPoints(frontier) %>>%
  data.frame(
    SP500 = frontier@portfolio@portfolio$weights[,2],
    BofAMLCorp = frontier@portfolio@portfolio$weights[,1]
  ) %>>%
  plot_ly(x=~targetRisk, y=~targetReturn) %>>%
  add_markers(
    text = ~sprintf(
      "S&P 500: %.1f%%<br />BofA ML Corp: %.1f%%<br />Return: %.2f%%<br />Risk: %.2f%%",
      SP500 * 100,
      BofAMLCorp * 100,
      targetReturn * 100,
      targetRisk * 100
    ),
    hoverinfo = "text"
  ) %>>%
  layout(
    title = "Efficent Frontier"
  )

frontier@portfolio@portfolio$weights %>>%
  (weights~{
    plot_ly(
      x = ~1:nrow(weights)
    )  %>>%
      add_markers(y = ~weights[,"SP500"], name="SP500") %>>%
      add_markers(y = ~weights[,"BofAMLCorp"], name="BofAMLCorp")
  }) %>>%
  layout(hovermode = "x")
