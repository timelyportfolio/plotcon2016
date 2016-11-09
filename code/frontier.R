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
    title = "Efficient Frontier"
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


# now attempt a rolling frontier with plotly animation
SPEC = portfolioSpec()
setTargetReturn(SPEC) = 0
CONSTRAINTS = "LongOnly"

from = seq(1975, 2010, by = 5)
to = from + 5

rf <- returns_xts %>>%
  na.omit() %>>%
  as.timeSeries() %>>%
  {
    rollingPortfolioFrontier(
      data = .,
      spec = SPEC,
      constraints = CONSTRAINTS,
      from = timeDate(paste0(from,"-12-31")),
      to = timeDate(paste0(to,"-12-31"))
    )
  }

rf %>%
  map_df(
    function(frontier){
      frontierPoints(frontier) %>>%
        data.frame(
          SP500 = frontier@portfolio@portfolio$weights[,2],
          BofAMLCorp = frontier@portfolio@portfolio$weights[,1],
          date = getSeries(frontier@data) %>>%
            tail(1) %>>%
            rownames() %>>%
            as.character,
          stringsAsFactors = FALSE
        )
    }
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
    color = ~date,
    hoverinfo = "text",
    frame = ~date,
    showlegend = FALSE
  ) %>>%
  layout(
    title = "<b>Efficient Frontier</b><br>Rolling 5 Year",
    margin = 100
  ) %>>%
  animation_opts( frame = 2000, transition = 1000 )


upload_plotly <- function(p){
  Sys.setenv("plotly_username" = "timelyportfolio")
  Sys.setenv("plotly_api_key" = "3f9xw96gq0")

  plotly_POST(p)
}