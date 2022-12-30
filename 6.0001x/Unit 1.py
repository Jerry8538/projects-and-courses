# -*- coding: utf-8 -*-
# =============================================================================
# s= 'bobob'
# count = 0
# bobcount = 0
# for letter in s:
#     count +=1
#     if letter == 'b':
#         try:
#             s[count + 1] == 'o'
#         except:
#             break
#         if s[count] == 'o':
#             if s[count + 1] == 'b':
#                 bobcount += 1
#                 
#         
# print(count , bobcount)
# =============================================================================
# =============================================================================
# QUESTION 3
# =============================================================================
# =============================================================================
# s='abcbcd' #the weird word we use
# counter = 0
# 
# longchar = None #this stores the longest list of characters
# temp = None     #this stores the  longest list of chars of that iteration
# start = 0       #this stores the start position of the long string of chars
# end = 0         #this keeps track of the end of the chars
# linearcount = True
# counttracker = 0
# while True:
#     linearcount = False
#     counter += 1 #increments with every letter
#     
#     try:
#         s[counter] #exits the loop when out of characters
#     except:
#         break
#     
#     if s[counter - 1] <= s[counter]: #if the current letter is before or equal
#                                      #to the next letter
#         
# #the idea here is that if the longchar was set to the temp, which means that 
# #the longest word was found, the next iteration will start by setting the new
# #start position.
#         if counttracker == counter:
#             linearcount = True
#             
#         if longchar == temp and linearcount == True:
#             start = counter - 1
#         
#         
#         temp = s[start:counter + 1]
#         print(temp)
#     
#         
#         if longchar == None or len(longchar) < len(temp):
#             longchar = temp
#         print(longchar)
#         
#         counttracker = counter
#         
# print('Longest substring in alphabetical order is: ' , longchar)
# =============================================================================


   
#Question 3 try 2

# =============================================================================
# s='azcbobobegghakl'
# start = 0
# end = 1
# longchar = None
# temp = 'a'
# 
# for letter in s:
# =============================================================================
    
# =============================================================================
# s = 'azcbobobegghakl'
# temp = None
# count = 0
# longchar = None
# for letter in s:
#     
# 
# =============================================================================

# =============================================================================
# #PSET 1 - PROBLEM 3 - HOORAY!!!!
# 
# start = 0
# end = 0
# s= 'zyxwvutsrqponmlkjihgfedcba'
# longchar= None
# 
# while True:
#     
#     try: s[end]
#     except:break
#     
#     if s[end - 1] <= s[end]:
#         end += 1
#     elif s[end - 1] > s[end]:
#         start = end
#         end +=1
#     if longchar == None or len(s[start:end]) > len(longchar):
#         longchar = s[start:end]
# print(longchar)
# =============================================================================

#Some Improvements - 

start = 0
end = 0
s= 'trwxqkidqaglkvjfmfptnnnz'
longchar= None

while end < len(s):
    #If the next character is smaller, then increase the length
    if s[end - 1] <= s[end]:
        end += 1
    #If the next character is greater, start from there
    elif s[end - 1] > s[end]:
        start = end
        end +=1
    if longchar == None or len(s[start:end]) > len(longchar):
        longchar = s[start:end]
print(longchar)