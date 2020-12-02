rm(list=ls())
# Task 1
library(rvest)
link = "http://www.forecasts.org/"
page = read_html(link)
table = html_table(page, fill=TRUE)
table

Indicator = table[[1]][,1][-1]
Current = as.numeric(table[[1]][,2][-1])
Forecast11 = as.numeric(table[[1]][,3][-1])
Forecast12 = as.numeric(table[[1]][,4][-1])
forecast_summary.df = data.frame(Indicator, Current, Forecast11, Forecast12)

Indicator = table[[2]][3:8,1]
Value = table[[2]][3:8,2]
current_economic_indicators.df = data.frame(Indicator, Value)

# Task 2
library(pdftools)
working.directory = getwd()
appleQ42019.pdf = paste(sep = "", working.directory, "/Q4-FY19-Consolidated-Financial-Statements.pdf")
txt = pdf_text(pdf = appleQ42019.pdf)
page = txt [3]
rows = scan(textConnection(page), what = "character", sep = "\n")
dat = unlist(strsplit(rows, " \\s+ "))
dat = gsub("[\\$,]", "", dat)
dat = gsub("^\\(([0-9]+)\\)$", "-\\1", dat)
dat = dat[!(dat %in% c(""))]
dat[!grepl("^[a-zA-Z0-9-]", dat)] = c("(In millions)", "0")
# generally the last five lines are cleaning and processing the raw data read from the pdf file directly
# line1: split the item in rows with more than three whitespaces and unlist them, so dat has the all the result in list
# line2: replace all '$' and ',' with '' in the dat, such that, delete '$' and ','
# line3: replace all data in '()' with a negativa sign (eg: '(105)'->'-105')
# line4: delete all the empty ""
# line5: For item not starting with "a-z", "A-Z", "0-9" or "-", replacing them with c("(In millions)", "0")

# Task 3
library(quantmod)
# 1
getSymbols("AAPL",src="yahoo",from = "2019-07-01", to = "2019-10-31") # from yahoo finance
chartSeries(AAPL)
# 2
getSymbols("AAPL",src="yahoo",from = "2011-01-07", to = "2019-10-31") # from yahoo finance
chartSeries(AAPL, TA=c(addBBands(20, 3), addMACD()), theme=chartTheme('white'))
AAPL.week = to.weekly(AAPL)
chartSeries(AAPL.week,TA=c(addBBands(20, 3), addMACD()), theme = 'white')
# Task 4
table2 = html_table(read_html("https://fred.stlouisfed.org/graph/api/series/?obs=true&sid=TOTALSA"), fill=TRUE)

