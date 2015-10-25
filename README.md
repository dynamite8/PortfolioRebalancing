Portfolio Rebalancing
==========

This project samples some of the techniques used to implement a framework for iOS application using Objective-C.

Functional spec
------------------------------

For this exercise, the problem statement is as follows:

Create a portfolio rebalancing module. Each WealthSimple customer has a portfolio with a set of investments along with target allocations for these investments. However, as share prices fluctuate, the actual allocations of investments may diverge from the target allocations. For example:


| Ticker  | Target allocation | Actual allocation | Shares owned | Share price
| ------------- | ------------- || ------------- || ------------- || ------------- |
| GOOG | 60% | 50.96% | 52 | $98 |
| AAPL | 30% | 29.92% | 136 | $22 |
| TSLA | 10% | 19.12% | 239 | $8 |

The job of the rebalancing module is to buy or sell shares to bring the actual allocation of investments as close as possible to the target allocations.

This program should not have any UI. It should take in the current state of investments and target allocations as inputs, and output the set of buys and sells necessary to rebalance these investments (e.g buy 9 shares of GOOG, sell 114 shares of TSLA).

Technical decisions
------------------------------
Since there is no UI for the program, I have decided to create a reusable iOS framework using Objective-C.  The first version of the framework is captured in the tag named v0.1.1_20151025\_1814.  This version solves the problem and contains couple of test cases to test the functionality of rebalancing a portfolio.  It is working as expected.

For the second approach, I tried to do was rewriting the framework to use a manager concept, which is a singleton or shared instance in the framework. This Portfolio manager is in charge of the following:
- Initiating the portfolio
- Retrieving the current share prices for tickers in the portfolio
- Returning the transactions to rebalance the portfolio using a strategy

The goal of refactoring the code was to decouple the strategy, portfolio, update of the ticker share prices.  This approach further allows the developers to extend the strategy and implement other rebalancing strategy if desired.  Any new strategies will need to implement the protocol to provide the necessary functionality.  I have also simulated the retrieval of the portfolio and ticker prices via webservices (or files for now).  Overall, the goal was to make the framework easily extendable to add additional strategies, and other features.

The organization of the file structure was also intended to make the files easier to locate and the code easier to read.

|-- PortfolioRebalancing
    |-- Info.plist
    |-- PortfolioManager.h
    |-- PortfolioManager.m
    |-- PortfolioRebalancing.h
    |-- Features
    |   |-- Portfolio
    |   |   |-- Portfolio.h
    |   |   |-- Portfolio.m
    |   |-- Strategy
    |   |   |-- PortfolioRebalanceStrategy.h
    |   |   |-- PortfolioRebalanceStrategy.m
    |   |   |-- TargetAllocation
    |   |       |-- TargetAllocationStrategy.h
    |   |       |-- TargetAllocationStrategy.m
    |   |-- Webservice
    |       |-- PortfolioServices.h
    |       |-- PortfolioServices.m
    |       |-- RetrievePortfolio
    |       |   |-- PortfolioServices+RetrievePortfolio.h
    |       |   |-- PortfolioServices+RetrievePortfolio.m
    |       |-- RetrieveTickerPrices
    |           |-- PortfolioServices+RetrieveTickerPrices.h
    |           |-- PortfolioServices+RetrieveTickerPrices.m
    |-- Models
    |   |-- Ticker+TargetAllocation.h
    |   |-- Ticker+TargetAllocation.m
    |   |-- Ticker.h
    |   |-- Ticker.m
    |-- Samples
    |   |-- CurrentPricesForTickers.json
    |   |-- FinancialPortfolio.json
    |   |-- SamplePortfolio.json
    |-- Utilities
        |-- PortfolioUtility.h
        |-- PortfolioUtility.m


Trade-offs
------------------------------
If I have more time, I will make the second approach work.  It is not functional at the moment.  I will continue troubleshooting the issues.


Authors
-------

The spec was provided as a programming challenge and implemented by Jenny Chang Ho.
