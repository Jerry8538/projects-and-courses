# -*- coding: utf-8 -*-
"""
Created on Mon Jun 21 22:10:51 2021

@author: The Khators
"""

def payment_sim(balance , monthlyInterestRate , monthlyPaymentAmount):
    """

    Parameters
    ----------
    balance : Int
        Just the balance.
    annualInterestRate : Int
        The annual interest rate.
    monthlyPaymentAmount : Int
        This is what I am using to run the payment simulator, and trying to get it as low as possible.

    Returns
    -------
    Boolean
        Checks whether the monthlypaymentamount is as low as possible.
    
    """
    year = 12
    
    for month in range(year):

        #This is where we pay our monthly payment
        balance -= monthlyPaymentAmount
        #This is where we add the interest
        balance += (monthlyInterestRate) * balance
        
    if balance > 0:
        aboveorbelowzero = 1
        
    if balance < 0:
        aboveorbelowzero = -1
        
    return abs(balance) < 0.01 , aboveorbelowzero

#Setting values for test cases
balance = 999999
annualInterestRate = 0.18

PaymentLowEnough = False
monthlyInterestRate = annualInterestRate/12

#Setting the upper and lower bounds
upperbound = (balance * (1 + monthlyInterestRate)**12) / 12
lowerbound = balance/12

#BISECTION SEARCH BABYYYYY
while PaymentLowEnough == False:
    
      middle = (upperbound + lowerbound) / 2
      monthlyPaymentAmount = middle
      
      PaymentLowEnough , aboveorbelowzero = payment_sim(balance, monthlyInterestRate, monthlyPaymentAmount)

      if aboveorbelowzero == 1:
          lowerbound = middle
          
      if aboveorbelowzero == -1:
          upperbound = middle
          
      
print(' The lowest Monthly Payment is -' , round(monthlyPaymentAmount , 2))
      
      
      
    