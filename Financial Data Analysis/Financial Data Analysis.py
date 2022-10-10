# -*- coding: utf-8 -*-
"""
Created on Fri Oct  7 11:17:13 2022

@author: omidh
"""

# This is a finance data analysis project

# Importing the required libraries:

import numpy as np
import pandas as pd
import matplotlib as mpl
from scipy.optimize import minimize
import matplotlib.pyplot as plt
import pprint

from Historic_Crypto import Cryptocurrencies
from Historic_Crypto import HistoricalData
import yfinance as yf

# The first group of imports is for basic operations. 
# The second (Historic_Crypto and yfinance) imports the libraries that we will use to download financial data.


netflix = yf.Ticker("NFLX")

# We have used the Ticker class of the yfinance library to create a netflix object. 
# This object contains attributes and methods that we can query to obtain various types of information.

netflix_info = netflix.info
# pprint.pprint(netflix_info)

hist = netflix.history(period="max")

# First portfolio

# Preparing portfolio data

# Styling the plots

plt.style.use("fivethirtyeight")
mpl.rcParams["savefig.dpi"] = 300
mpl.rcParams["font.family"] = "serif"
np.set_printoptions(precision=5, suppress=True, formatter={"float": lambda x: f"{x:6.3f}"})

# Suppose we want to measure the performance of a portfolio consisting of Google, Apple, Microsoft, Netflix and Amazon stocks.

SYMBOLS_1 = ["GOOG", "AAPL", "MSFT", "NFLX", "AMZN"]

# We are going to download the historical data for this portfolio. 
# To do this, we are going to use the yfinance download() function, 
# which takes as its first argument a string with the symbols (SYMBOLS_1) defined above. 
# The rest of the arguments are the start date (start="2012-01-01"), the end date (end="2021-01-01") 
# and how the data will be grouped (group_by="Ticker").


data_1 = yf.download(" ".join(SYMBOLS_1), start="2012-01-01", end="2021-01-01", group_by="Ticker")
# The last argument (group_by="Ticker") groups the information mainly by stock.

data_1 = data_1.stack(level=1).rename_axis(["Date", "Ticker"]).reset_index(level=1)

# We only need the daily closing prices
close_data_1 = data_1[data_1.Ticker == "Close"].drop("Ticker", inplace=False, axis=1)

# We want to see how our portfolio would have performed if we had invested in it from 2012 to early 2021. 
# How could we obtain this measurement? 
# Let’s look at the monthly closing prices of each stock. 
# To do this we will do an automatic resample of the data. 
# And then we will calculate the change in relative frequencies (percentages).

# The resampling will be performed with the resample("M") method 
# and the calculation of percentages with the pct_change() method. 

monthly_data_1 = close_data_1.resample("M").ffill().pct_change()

monthly_data_1.mean()

# NOTE: Remember that this closing information represents the relative growth of each stock, 
# not its closing price in any currency.

# As we can see, all the results are positive, so this portfolio has been profitable over the years. 
# In relative terms, the biggest gains would come from Netflix (0.04 percent). 
# These percentages show an average of the monthly variation of the stock price. 
# But how stable have that prices been? To find this out, we can calculate the standard deviation of stock price growth

monthly_data_1.std()

# The highest volatility is found in Netflix (0.1454), 
# which indicates that its price, despite being the fastest growing, has also had a lot of variation during these years. 
# The most stable price, on the other hand, has been Microsoft’s (0.0583).



# A good way to observe both growth and variability is to draw a time-series plot. To scale the values, 
# we are going to divide the relative frequency of the closing price of the actions by the initial value it has 
# in the dataframe close_data_1 (these initial values can be found with close_data_1.iloc[0])). 
# The plot is drawn with the plot() method of the Pandas DataFrame (to which we pass as arguments the size of the plot 
# and the plot title).
(close_data_1/close_data_1.iloc[0]).plot(figsize=(16, 10), title="Portfolio 1 daily stock price")


(monthly_data_1 + 1).cumprod().plot(figsize=(16, 10), title="Portfolio 1 monthly stock price")


rets_1 = np.log(close_data_1/close_data_1.shift(1)).dropna()
# Trend lines are more easily drawn in logarithmic scale because they tend to fit better to the minimums. 
# In addition, the logarithmic scale gives a more realistic view of price movements.

# In addition to the returns of each stock, we will need the specific weight of each stock in the portfolio, 
# i.e., how many shares of each company are in the portfolio. 
# In this workshop we will assume that there is one share of each company and, therefore, the weights will be distributed equally.


# NOTE:
    # A stock is a financial security that represents that you own a part of a company (whatever the size of this part). 
    #A share, on the other hand, is the smallest unit of denomination of a stock. A stock is composed of one or several shares.


weights_1 = [0.2, 0.2, 0.2, 0.2, 0.2]

def portfolio_return(returns, weights):
    return np.dot(returns.mean(), weights) * 252

portfolio_return(rets_1, weights_1)

# An expected gain of almost 30% in one year. Not bad, right? But don’t forget the other side of this coin: 
# volatility. This calculation is a bit more complex. 
# First, the dot product of the annualized covariance of the returns (this is multiplied by the number of trading days in a year) 
# and the weights is calculated. Then the dot product of the weights and the previous result is obtained. 
# Finally, the square root of this result is extracted. Let’s implement this into a function as well.

def portfolio_volatility(returns, weights):
    return np.dot(weights, np.dot(returns.cov() * 252, weights)) ** 0.5

# Let’s see how our portfolio performs with respect to its volatility:

portfolio_volatility(rets_1, weights_1)

# If high return is desirable, high volatility is undesirable. The risk of this portfolio is relatively large.

# Sharpe ratio
# The Sharpe ratio or index is a measure of portfolio performance. 
# It relates the portfolio’s return to its volatility, comparing the expected/realized return with the expected/realized risk. 
#It is calculated as the difference between the actual investment returns and the expected return in a zero-risk situation, 
#divided by the volatility of the investment. 
# It provides a model of the additional amount of returns received for each additional unit of risk.

def portfolio_sharpe(returns, weights):
    return portfolio_return(returns, weights) / portfolio_volatility(returns, weights)

portfolio_sharpe(rets_1, weights_1)


# NOTE:
    # The Sharpe ratio measure is best understood in context: 
    # when comparing two or more portfolios, the one with the higher Sharpe ratio provides more profit for the same amount of risk.


# We can also use a Monte Carlo simulation to randomize the weights of each stock in the portfolio 
# so that we can see the range over which the Sharpe ratio can vary. 
# In this way we can plot some scenarios that together will give us a good insight of the relationship between 
# expected returns and expected volatility.

def monte_carlo_sharpe(returns, symbols, weights):

    sim_weights = np.random.random((1000, len(symbols)))
    sim_weights = (sim_weights.T / sim_weights.sum(axis=1)).T

    volat_ret = [(portfolio_volatility(returns[symbols], weights), portfolio_return(returns[symbols], weights)) for weights in sim_weights]
    volat_ret = np.array(volat_ret)

    sharpe_ratio = volat_ret[:, 1] / volat_ret[:, 0]

    return volat_ret, sharpe_ratio

port_1_vr, port_1_sr = monte_carlo_sharpe(rets_1, SYMBOLS_1, weights_1)


plt.figure(figsize=(16, 10))
fig = plt.scatter(port_1_vr[:, 0], port_1_vr[:, 1], c=port_1_sr, cmap="cool")
CB = plt.colorbar(fig)
CB.set_label("Sharpe ratio")
plt.xlabel("expected volatility")
plt.ylabel("expected return")
plt.title(" | ".join(SYMBOLS_1))


# Optimal portfolio weights

start_year, end_year = (2012, 2020)

def optimal_weights(returns, symbols, actual_weights, start_y, end_y):

    bounds = len(symbols) * [(0, 1), ]
    constraints = {"type": "eq", "fun": lambda weights: weights.sum() - 1}
    opt_weights = {}

    for year in range(start_y, end_y):
        _rets = returns[symbols].loc[f"{year}-01-01":f"{year}-12-31"]
        _opt_w = minimize(lambda weights: -portfolio_sharpe(_rets, weights), actual_weights, bounds=bounds, constraints=constraints)["x"]
        opt_weights[year] = _opt_w
    return opt_weights


# Let’s describe this function in broad strokes. 
# bounds indicates the maximum and minimum weights for each stock in the portfolio. 
# The lowest weight will be 0 and the highest weight will be 1 for each stock in the portfolio. 
# constraints is a function that ensures that the sum of the weights of all actions always adds up to 1. 
# Then a loop is initialized that will segment the data for each year. 
# In the variable _rets the returns for the specified year are obtained. 
# In _opt_w the portfolio_shape() function is used to calculate the weights that maximize the Sharpe ratio. 
# This is done with the minimize() function of SciPy (which takes as arguments the portfolio_shape function, 
# the actual weights of our stocks in the portfolio, and the bounds and the constraints variables). 
# Notice the - sign before portfolio_sharpe? 
# It’s because minimize() aims to find the minimum value of a function relative to a parameter, but we are interested in the maximum, 
#so we make the result of portfolio_sharpe a negative one.

# We will use the function we just defined to calculate the optimal weights for each year, 
# and we are going to save the result in a Pandas DataFrame to take advantage of the Variable Explorer display options.

opt_weights_1 = optimal_weights(rets_1, SYMBOLS_1, weights_1, start_year, end_year)
port_1_ow = pd.DataFrame.from_dict(opt_weights_1, orient='index')
port_1_ow.columns = SYMBOLS_1


# Comparison of expected and realized returns

def exp_real_rets(returns, opt_weights, symbols, start_year, end_year):

    _rets = {}
    for year in range(start_year, end_year):
        prev_year = returns[symbols].loc[f"{year}-01-01":f"{year}-12-31"]
        current_year = returns[symbols].loc[f"{year + 1}-01-01":f"{year + 1}-12-31"]
        expected_pr = portfolio_return(prev_year, opt_weights[year])
        realized_pr = portfolio_return(current_year, opt_weights[year])
        _rets[year + 1] = [expected_pr, realized_pr]

    return _rets

#In this function we compare year to year realized returns with theoretically expected returns. This is done by estimating:

    #The returns from applying the optimal weights of the previous year’s stocks to the data for that same year (expected_pr).

    #The returns from applying the optimal weights of the previous year’s stocks to the following year’s data (realized_pr).

# We are going to apply this function to the data in portfolio 1 and store the results in a DataFrame that 
# we can review in the Variable Explorer.

port_1_exp_real = pd.DataFrame.from_dict(exp_real_rets(rets_1, opt_weights_1, SYMBOLS_1, start_year, end_year), orient='index')
port_1_exp_real.columns = ["expected", "realized"]


port_1_exp_real.plot(kind="bar", figsize=(16, 10),title="Expected vs. realized Portfolio Returns")

port_1_exp_real.mean()

port_1_exp_real[["expected", "realized"]].corr()















