"""
#making the variables 'largest' and 'smallest' blank
largest = None
smallest = None

#An infinite loop
while True:

    #This part gets the input
    num = input("Enter a number: ")

    #this section makes sure we have numbers

    #this exits the loop if input is "done"
    if num == "done":
        break
    
    #this checks if input is correct   
    elif num != "done":
        try:
            inum = int(num)
        except:
            print("Invalid input")
            continue
    
    #onto the comparing bit

    inum = int(num)       

    #finds largest
    if largest is None:
        largest = inum

    elif largest < inum:
        largest = inum    

    #finds smallest
    if smallest is None:
        smallest = inum

    elif smallest > inum:
        smallest = inum
 
#when the user inputs "done", we go here and give the output
print("Maximum is" , largest)
print("Minimum is" , smallest) 



text = "X-DSPAM-Confidence:    0.8475"
extract = text.find("0.8475" , )
print(float(text[extract+2:]))

# Use the file name mbox-short.txt as the file name
sum_of_values = None
count = 0
fname = input("Enter file name: ")
fh = open(fname)
for line in fh:
    if not line.startswith("X-DSPAM-Confidence:"):
        continue
    extract = line.find("0")
    newline = line.find("/n")
    number = line[extract:newline]
    if sum_of_values is None:
        sum_of_values = float(number)
    elif sum_of_values is not None:
        sum_of_values = sum_of_values + float(number)
    count = count + 1
print(sum_of_values / count)


#8.4 Open the file romeo.txt and read it line by line. 
#For each line, split the line into a list of words using the split() method.
#The program should build a list of words. 
#For each word on each line check to see if the word is already in the list and if not append it to the list.
#When the program completes, sort and print the resulting words in alphabetical order.

listofwords = list()
fname = input("Enter the filename (romeo.txt): ")
while fname != "romeo.txt":
    print("Incorrect filename, this program needs romeo.txt")
    fname = input("Enter the filename (romeo.txt): ")

filename = fname.lower().strip()

fh = open(fname)
for line in fh:
    words = line.split()
    for word in words:
        if word in listofwords:
            continue
        else:
            listofwords.append(word)

listofwords.sort()
print(listofwords)



fname = input("Enter the filename (mbox-short.txt): ")
listofwords = list()
fh = open(fname)
count = 0

for line in fh:
    if line.startswith("From "):
        words = line.split()
        listofwords.append(words[1])
        count = count + 1

for emails in listofwords:
    print(emails)
    
print("There were" , count , "lines in the file with From as the first word")



fname = "mbox-short.txt"
fh = open(fname)
listofwords = list()

for line in fh:
    if line.startswith("From "):
        words = line.split()
        listofwords.append(words[1])

dictionary = dict()

bigword = None
bigcount = 0

for word in listofwords:
    dictionary[word] = dictionary.get(word , 0) + 1
    if dictionary[word] > bigcount:
        bigword = word
        bigcount = dictionary[word]

print(bigword , bigcount)



fname = "mbox-short.txt"
fh = open(fname)
listoftimes = list()

for line in fh:
    if line.startswith("From "):
        words = line.split()
        listoftimes.append(words[5])

listofhours = list()

for time in listoftimes:
    splittime = time.split(":")
    listofhours.append(splittime[0])



dct = dict()

for hours in listofhours:
    dct[hours] = dct.get(hours , 0) + 1



lst = list()

for k , v in dct:
    lst = list(dct.items())



lst  = sorted(lst)

for key , val in lst:
    print(key , val)


import re

fh = open("file.txt")

listofnums = list()

for line in fh:
    find = re.findall('[0-9]+' , line)
    if len(find) < 1 :
        continue
    for num in find:
        fnum = int(num)
        listofnums.append(fnum)

print(sum(listofnums))



from bs4 import BeautifulSoup
import urllib.request , urllib.parse , urllib.error

fhand = urllib.request.urlopen('http://www.dr-chuck.com/page1.htm')

for line in fhand:
    print (line.decode().strip())



import socket
import re

mysock = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
mysock.connect(('data.pr4e.org', 80))
cmd = 'GET http://data.pr4e.org/intro-short.txt HTTP/1.0\r\n\r\n'.encode()
mysock.send(cmd)

lst = list()

while True:
    data = mysock.recv(512)
    if len(data) < 1:
        break
    lst.append(data)

text = lst[0].decode()

lst_2 = list()

splittext = text.split('\n')

for lines in splittext:
    if lines == '\r':
        break
    pos = lines.find('\r')
    
    lst_2.append(lines[:pos])

for items in lst_2:
    print(items)
        
mysock.close()



import urllib.request , urllib.parse , urllib.error 
from urllib.request import urlopen
from bs4 import BeautifulSoup
import ssl

# Ignore SSL certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = "http://py4e-data.dr-chuck.net/comments_1195086.html"
html = urlopen(url, context=ctx).read()
soup = BeautifulSoup(html, "html.parser")

listofnums = list()
# Retrieve all of the anchor tags
tags = soup('span')
for tag in tags:
    nums = int(tag.contents[0])
    listofnums.append(nums)

print(sum(listofnums))



# To run this, download the BeautifulSoup zip file
# http://www.py4e.com/code3/bs4.zip
# and unzip it in the same directory as this file

from urllib.request import urlopen
from bs4 import BeautifulSoup
import ssl

# Ignore SSL certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

listofurls = list()
listofurls.append('http://py4e-data.dr-chuck.net/known_by_Kyel.html')

listoflinks = list()

count = 0

for urls in listofurls:
    url = urls

    html = urlopen(url, context=ctx).read()
    soup = BeautifulSoup(html, "html.parser")

    tags = soup('a')

    listoflinks.clear()

    for tag in tags:
        link = tag.get('href' , None)
        
        listoflinks.append(link)
        
        if len(listoflinks) == 18:
            listofurls.append(listoflinks[17])
            break
    
    count = count + 1
    if count == 7:
        print(listofurls[7])
        break
    else:
        continue


        
import urllib.request, urllib.parse, urllib.error
from urllib.request import urlopen
import xml.etree.ElementTree as ET
import ssl

# Ignore SSL certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = "http://py4e-data.dr-chuck.net/comments_1195088.xml"

html = urlopen(url, context=ctx)
ht = html.read()
data = ht.decode()
print(data)
tree = ET.fromstring(data)


lst = list()

lst = tree.findall('comments/comment/count')
lst_2 = list()

for counts in lst:
    lst_2.append(int(counts.text))

    

print(sum(lst_2))




import urllib.request, urllib.parse, urllib.error
from urllib.request import urlopen
import xml.etree.ElementTree as ET
import ssl
import json

# Ignore SSL certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE

url = "http://py4e-data.dr-chuck.net/comments_1195089.json"

html = urlopen(url, context=ctx).read().decode()



data = json.loads(html)


comments = list()



comments = data['comments']

num = list()

for items in comments:
    num.append(int(items['count']))



print(sum(num))




import urllib.request, urllib.parse, urllib.error
import json
import ssl



key = 42
serviceurl = 'http://py4e-data.dr-chuck.net/json?'


# Ignore SSL certificate errors
ctx = ssl.create_default_context()
ctx.check_hostname = False
ctx.verify_mode = ssl.CERT_NONE
parms = dict()
parms['key'] = key
while True:
    address = input('Enter location: ')
    if len(address) < 1: break

    parms['address'] = address
    
    url = serviceurl + urllib.parse.urlencode(parms)

    uh = urllib.request.urlopen(url, context=ctx).read().decode()

    js = json.loads(uh)

    print(json.dumps(js, indent=4))

    id = js['results'][0]['place_id']
    
    print(id)




import sqlite3

conn = sqlite3.connect('org.sqlite')
cur = conn.cursor()



cur.execute('''
CREATE TABLE Counts (org TEXT, count INTEGER)''')

fname = 'mbox-short.txt'
fh = open(fname)
for line in fh:
    if not line.startswith('From: '): continue
    pieces = line.split()
    email = pieces[1]
    split = email.split('@')
    domain = split[1]
    cur.execute('SELECT count FROM Counts WHERE domain = ? ', (domain,))
    row = cur.fetchone()
    if row is None:
        cur.execute('''INSERT INTO Counts (domain, count)
                VALUES (?, 1)''', (domain,))
    else:
        cur.execute('UPDATE Counts SET count = count + 1 WHERE domain = ?',
                    (domain,))
    conn.commit()

# https://www.sqlite.org/lang_select.html
sqlstr = 'SELECT domain, count FROM Counts ORDER BY count DESC LIMIT 100'

for row in cur.execute(sqlstr):
    print(str(row[0]), row[1])

cur.close()

"""