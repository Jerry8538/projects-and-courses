def genPrimes():

    #a number is prime if the number divided by all previous prime numbers is prime
    #initialize the list with nothing, and start with two, since 0 and 1 are not primes
    listofPrimes = []
    consecNum = 2
    
    while True:
        #raises exception if not a prime
        try:
            for Prime in listofPrimes:
                if consecNum % Prime == 0:
                    raise Exception
        #if not a prime
        except:
            consecNum += 1
            continue
        #if it is a prime, append to the listofPrimes, and yield it
        else:
            listofPrimes.append(consecNum)
            yield consecNum
            consecNum += 1
                

test = genPrimes()
count = 0
while count != 100:
    print(test.__next__())
    count += 1