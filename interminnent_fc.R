# Intermittent demand forecasting package for R
" By Harikumar Balakrishanna | May 20, 2020 "

# Description
# 
# Intermittent demand-when a product or SKU experiences several periods of zero demand-is highly variable. Intermittent demand is very common in industries such as aviation, automotive, defense, manufacturing, and retail. It also typically occurs with products nearing the end of their lifecycle.
# However, due to the many zero values in intermittent demand time series, the usual methods of forecasting, such as exponential smoothing and ARIMA, do not give an accurate forecast. In these cases, approaches such as Croston may provide a better accuracy over traditional methods. Prateek Nagaria compares traditional and Croston methods in R on intermittent demand time series.
# 
# Topics include:
# 
# The differences between traditional forecasting and intermittent forecasting
# A brief overview of different methods for intermittent demand forecasting
# Applying and interpreting the Croston method
# A comparison between traditional methods and the Croston method on real-world SKUs data in R

# _____________________________________________________________________________ #

# crost: Croston's method and variants.
# crost.ma: Moving average with Croston's method decomposition.
# idclass: Time series categorisation for intermittent demand.
# simID: Simulator for intermittent demand series.
# tsb: TSB (Teunter-Syntetos-Babai) method.

# Two demo time series are included to try the various functions: data and data2.

# To fit Croston's to a time series, simply use the following command:

# install.packages("tsintermittent")

library("tsintermittent")

# Load Data
crost(ts.data1)

# The function comes with a few different options. By default it optimises model parameters and initial values using the MAR cost function. Using the flag cost different cost functions are available. By default the smoothing parameter for the non-zero demand and demand intervals are optimised separately, but this can be controlled using the flag nop. Similarly the initialisation values for demand and intervals can be optimised or not and set either manually, or to preset initialisation heuristics. These are controlled by the flags init.opt and init.

# Three different variants of the method are implemented:
  
# 'croston', for the original method.
# 'sba', for the Syntetos-Boylan approximation.
# 'sbj', for the Shale-Boylan-Johnston correction.

# For example, to get SBA forecasts with optimal parameters for 12 months ahead and plot the results you can use:
  
crost(ts.data1,type='sba',h=12,outplot=TRUE)

# This will provide the following visual output:
# Functions tsb and crost.ma allow similar level of control.
# The next interesting function in the package allows you to create simulated intermittent demand series. The simulator assumes that non-zero demand arrivals follow a bernoulli distribution and the non-zero demands a negative binomial distribution. For example to create 100 simulated time series, 60 observations each, use:
  
dataset <- simID(100,60,idi=1.15,cv2=0.3)

# The two last inputs control the average demand interval and the squared coefficient of variation of the non-zero demand for the series.
# To get a better view of the generated series, or a real dataset, we can use the idclass function. This categorises the intermittent demand time series according to existing classification schemes. In particular the following are implemented:
  
# 'SBC', classification proposed by Syntetos-Boylan-Croston.
# 'KH', the revised classification by Kostenko-Hyndman using the exact separation.
# 'KHa', as above but using the approximate separation.
# 'PK', the further revised classification that deals with temporal aggregation by Petropoulos-Kourentzes.
# 'PKa', as above but using the approximate separation.
# Both 'KH' and 'PK' require the demand interval smoothing parameter of SBA as input. This can either by calculated automatically by the function, or given as an input using the a.in flag.

# Finally there are two views for each classification. One summarised that merely provides the number of time series the class/method or a detailed one that provides a scatterplot of the time series characteristics. Here are some examples:
  
idclass(t(dataset))
# This gives by default the PKa classification.

idclass(t(dataset),type='SBC')
idclass(t(dataset),type='KHa')
idclass(t(dataset),type='PK',outplot='detail')

# Research Papers
# Refer to : 
# 1. https://medium.com/analytics-vidhya/croston-forecast-model-for-intermittent-demand-360287a17f5f