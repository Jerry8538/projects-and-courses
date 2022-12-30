# -*- coding: utf-8 -*-
"""
Created on Tue Jun 15 23:07:45 2021

@author: The Khators
"""

print('Please think of a number between 0 and 100')
high = 100
low = 0
inp = None

while inp != 'c':
    
    ans = int((high + low)/2)
    
    print('Is your secret number' , str(ans) + '?')
    inp = input("Enter 'h' to indicate the guess is too high. Enter 'l' to indicate the guess is too low. Enter 'c' to indicate I guessed correctly.")
    
    
    if inp == 'l':
        low = ans
        continue
    
    if inp == 'h':
        high = ans
        continue
    
    if inp == 'c':
        print('Game over. Your secret number was' , ans)
        continue
    
    else:
        print('Sorry, I did not understand your input.')
        continue
    
    