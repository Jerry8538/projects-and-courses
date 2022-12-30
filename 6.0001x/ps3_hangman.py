# Hangman game
#

# -----------------------------------
# Helper code
# You don't need to understand this helper code,
# but you will have to know how to use the functions
# (so be sure to read the docstrings!)

import random
import string

WORDLIST_FILENAME = "words.txt"

def loadWords():
    """
    Returns a list of valid words. Words are strings of lowercase letters.
    
    Depending on the size of the word list, this function may
    take a while to finish.
    """
    print("Loading word list from file...")
    # inFile: file
    inFile = open(WORDLIST_FILENAME, 'r')
    # line: string
    line = inFile.readline()
    # wordlist: list of strings
    wordlist = line.split()
    print("  ", len(wordlist), "words loaded.")
    return wordlist

def chooseWord(wordlist):
    """
    wordlist (list): list of words (strings)

    Returns a word from wordlist at random
    """
    return random.choice(wordlist)

# end of helper code
# -----------------------------------

# Load the list of words into the variable wordlist
# so that it can be accessed from anywhere in the program
wordlist = loadWords()

def isWordGuessed(secretWord, lettersGuessed):
    '''
    secretWord: string, the word the user is guessing
    lettersGuessed: list, what letters have been guessed so far
    returns: boolean, True if all the letters of secretWord are in lettersGuessed;
      False otherwise
    '''
    secretwordlist = []
    secretwordlist = [letter_SW for letter_SW in secretWord if letter_SW not in secretwordlist]

    for letter_LG in lettersGuessed:
        if letter_LG in secretwordlist:
            secretwordlist.remove(letter_LG)
            
    return secretwordlist == []
            



def getGuessedWord(secretWord, lettersGuessed):
    '''
    secretWord: string, the word the user is guessing
    lettersGuessed: list, what letters have been guessed so far
    returns: string, comprised of letters and underscores that represents
      what letters in secretWord have been guessed so far.
    '''
    secretwordlist = []
    secretwordlist = [letter_SW for letter_SW in secretWord if letter_SW not in secretwordlist]
    
    for letter_SWL in secretwordlist:
        if letter_SWL not in lettersGuessed:
            secretwordlist[secretwordlist.index(letter_SWL)] = '_ '
            
    return ''.join(secretwordlist)


def getAvailableLetters(lettersGuessed):
    '''
    lettersGuessed: list, what letters have been guessed so far
    returns: string, comprised of letters that represents what letters have not
      yet been guessed.
    '''
    list_of_alphabet = list(letter for letter in string.ascii_lowercase)
    list_of_unguessed = list_of_alphabet[:]
    
    for letterguessed in lettersGuessed:
        list_of_unguessed.remove(letterguessed)
        
    return ''.join(list_of_unguessed)
    

def hangman(secretWord):
    '''
    secretWord: string, the secret word to guess.

    Starts up an interactive game of Hangman.

    * At the start of the game, let the user know how many 
      letters the secretWord contains.

    * Ask the user to supply one guess (i.e. letter) per round.

    * The user should receive feedback immediately after each guess 
      about whether their guess appears in the computers word.

    * After each round, you should also display to the user the 
      partially guessed word so far, as well as letters that the 
      user has not yet guessed.

    Follows the other limitations detailed in the problem write-up.
    '''
    
    print('Welcome to the game, Hangman!')
    chooseWord(wordlist)
    print('I am thinking of a word that is', len(secretWord), 'letters long.')
    print('-------------')
    
    guessesleft = 8
    lettersGuessed = []
    
    secretwordlist = []
    secretwordlist = [letter_SW for letter_SW in secretWord if letter_SW not in secretwordlist]
    
    while guessesleft > 0 :
        
            print('You have', guessesleft, 'guesses left.')
            print('Available letters:', getAvailableLetters(lettersGuessed))
            guess = input('Please guess a letter: ')
            guess = guess.lower()
            
            if guess in lettersGuessed:
                print("Oops! You've already guessed that letter:", getGuessedWord(secretWord, lettersGuessed))
                print('-------------')
                continue
            
            lettersGuessed.append(guess)
            
            if guess in secretwordlist:
                print('Good guess:', getGuessedWord(secretWord, lettersGuessed))
                print('-------------')
                if isWordGuessed(secretWord, lettersGuessed) == True:
                    break

                continue
            
            else:
                print('Oops! That letter is not in my word:', getGuessedWord(secretWord, lettersGuessed))
                print('-------------')
                guessesleft -= 1
                continue
    
    if guessesleft == 0:
        print('Sorry, you ran out of guesses. The word was', secretWord)
        
    else:
        print('Congratulations, you won!')
    
            
            
                
            
            
            
            
            
    
        






# When you've completed your hangman function, uncomment these two lines
# and run this file to test! (hint: you might want to pick your own
# secretWord while you're testing)

secretWord = chooseWord(wordlist).lower()
hangman(secretWord)
