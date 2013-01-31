# Author: Devin Pastoor
# Code for Hadley Wickham's Stat 405: Statistical Computing and Data Analysis
# Associated pdf's and other files in Data Analysis Onenote Notebook


setwd("C:/Users/Devin Pastoor/Documents/Classwork/Data_Analysis")
rm(list = ls())                # clean out workspace

library(ggplot2)
library(plyr)

# Lecture 1 - Introduction -----------------------------------------------------
  
# Scatterplot basics



# find out information about set of data
?mpg
head(mpg)           # initial lines, can alternatively set # of lines (mpg, n=)
str(mpg)            # information about variables and their types
summary(mpg)        # summary statistics for each variable

#basic plotting 

qplot(displ, hwy, data = mpg)     #(x.var, y.var, data = ?)

#add aesthetics (shape/color options) 
qplot(displ, hwy, color = class, data = mpg)

# add facetting (subsets)
qplot(displ, hwy, data = mpg) + facet_grid(drv ~.)      # 4w-, f-, r-wheel drive
qplot(displ, hwy, data = mpg) + facet_grid(. ~ cyl)     # number of cylinders

# and even more depth with colors
qplot(displ, hwy, color = class, data = mpg) +           
  facet_grid(. ~ cyl)

# or shapes (but note the warning - too many shapes can be confusing)
qplot(displ, hwy, shap = class, data = mpg) +           
  facet_grid(. ~ cyl)

# with a large numbers of factors the grid can look awkward
qplot(displ, hwy, data = mpg) + facet_grid(~ class)

# reshape to 'wrap' ribbon to 2d 
qplot(displ, hwy, data = mpg) + facet_wrap(~class)

# can do 2 levels of facetting to compare
qplot(displ, hwy, data = mpg) + facet_grid(drv ~ cyl)  

# does not show complete data by default to prevent overplotting
qplot(cty, hwy, data = mpg)

# to plot all points must add a geom_jitter
qplot(cty, hwy, data = mpg, geom = "jitter")

# sometimes want to rearrange data to better ID trends
qplot(class, hwy, data = mpg)
qplot(reorder(class,hwy), hwy, data = mpg)                          # reorder by mpg mean
qplot(reorder(class,hwy), hwy, data = mpg, geom = "jitter")         # to see all data

# want to know if can reorder by a different summary statistic
?reorder
qplot(reorder(class,hwy, median), hwy, data = mpg, geom = "jitter") #reorder by mpg median

# boxplots are good for summarizing data
qplot(reorder(class,hwy), hwy, data = mpg, geom = "boxplot")

# can add additional layers
qplot(reorder(class,hwy), hwy, data = mpg, geom = c("jitter", "boxplot")) # boxplot on top
qplot(reorder(class,hwy), hwy, data = mpg, geom = c("boxplot", "jitter")) # jitter on top


# Lecture 2 - Displaying Distributions -----------------------------------------

# Given one variable, qplot will give a bar chart or histogram
qplot(cut, data = diamonds)
qplot(carat, data = diamonds)

# Can easily change bin height
qplot(carat, data = diamonds, binwidth = 1)
qplot(carat, data = diamonds, binwidth = 0.1)
qplot(carat, data = diamonds, binwidth = 0.01)
resolution(diamonds$carat)                       #can see the last set bin width

# Change axis width of previous plot
last_plot() + xlim(0,3)

qplot(table, data = diamonds, binwidth = 1)

#to zoom in on a plot region or set axes use xlim() and ylim()
qplot(table, data = diamonds, binwidth = 1) + xlim(50, 70)
qplot(table, data = diamonds, binwidth = 0.1) + xlim(50, 70)
qplot(carat, data = diamonds, binwidth = 0.1) + xlim(50, 70) + ylim(0, 50)
?coord_cartesian()

#additional aesthetics options (for pretty but ineffective plots)
qplot(depth, data = diamonds, binwidth = 0.2)
#adding a fill color
qplot(depth, data = diamonds, binwidth = 0.2, fill = cut) + xlim(55, 70)
qplot(depth, data = diamonds, binwidth = 0.2) + xlim(55, 70) + facet_wrap(~ cut)

#some problems
#stacking is hard to read, placing apart makes hard to compare
#relative abudance is hard to judge - just rescale to equal area

#large distances make comparisons hard
qplot(price, data = diamonds, binwidth = 500) + facet_wrap(~ cut)

#stacked heights hard to compare
qplot(price, data = diamonds, binwidth = 500, fill = cut)

#better, but still have differing relative abundances
qplot(price, data = diamonds, binwidth = 500, geom = "freqpoly", color = cut)

#Instead of count on y-axis, display density
# .. indicates that the variable isn't in original data
qplot(price, ..density.., data = diamonds, binwidth = 500, geom = "freqpoly",
      color = cut)

#to use with histogram you must be explicit
qplot(price, ..density.., data = diamonds, binwidth = 500, geom = "histogram") +
  facet_wrap(~ cut)

#lecture 3 - Graphical Extensions and Subsetting -------------------------------
# reading scatter plots - look for 3 things:
#     - global patterns
#     - local patterns
#     - deviations

# to get help with specific geom - eg: ?geom_smooth

# To set aesthetics to a particular value, you need to wrap the value in I()
qplot(price, carat, data = diamonds, color = "blue")
qplot(price, carat, data = diamonds, color = I("blue"))

# You can also vary alpha for visibility preferences 
qplot(price, carat, data = diamonds, alpha = I(1/10))
qplot(price, carat, data = diamonds, alpha = I(1/50))
qplot(price, carat, data = diamonds, alpha = I(1/100))
qplot(price, carat, data = diamonds, alpha = I(1/250))

qplot(table, price, data = diamonds)
qplot(table, price, data = diamonds, geom = "boxplot")

# can specify a grouping variable to determine which observations go to 
# which boxplot

#round_any requires plyr  
qplot(table, price, data = diamonds, geom = "boxplot", group = round_any(table, 1))
qplot(table, price, data = diamonds, geom = "boxplot", 
      group = round_any(table, 1)) + xlim(50, 70)


