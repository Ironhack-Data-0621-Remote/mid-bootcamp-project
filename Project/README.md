# Project 2 - Credit card offer classification model

## Objective

This project is part of the IronHack Data Analytics Bootcamp. It aims at understanding the demographics and other characteristics of its customers that accept a credit card offer and that do not accept a credit card.

To do so, I built different classification models to predict whether or not a bank customer would accept the offer (see python file in the folder). I also used SQL to get some general information on the dataset and to provide insight into why some bank customers accept credit card offers (see SQL file in the folder). Finally, I visualized the results in tableau (see tableau file in the folder)

## Exploring the Data
The bank customers data was retrieved from the data file "creditcardmarketing.csv" saved in the data folder. The initial dataset contains 18 000 rows and 16 columns indicating customers information.

## Data cleaning
The data cleaning process was done in the following steps: 
- Check general details of data
- Standardize headers names (remove special characters, make it lowercase etc...)
    

## Machine learning: predict whether a bank customer would accept the credit card offer or not

Two machine learning models were built and compared
- Logistic regression model: using different sampling techniques to deal with data imbalance (see graph below)--> accuracy of around 69%
- K-Nearest Neighbor classifier model --> accuracy of around 78%



## Libraries
The libraries used in this machine learning project are listed hereafter: pandas, scikitplot, scipy.stats, os, sklearn, pymysql, sqlalchemy, imblearn, warnings, getpass
