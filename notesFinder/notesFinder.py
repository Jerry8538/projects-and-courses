import shutil,os

FILES = ['textbook']
SOURCE = '/home/yk/OSSU-CS'
OUTPUT = '/home/yk/Desktop/study'

def moveFiles (subject,chapter):
    for f in FILES:
        shutil.copy(f'{SOURCE}/notesFinder/files/{subject}/{chapter}/{f}.pdf',
                    f'{OUTPUT}/{f}.pdf')

def removeFiles():
    for f in FILES:
        os.remove(OUTPUT + f'/{f}.pdf')

# goes until file opened
while True:
    sub = input('Enter subject: ')
    chap = input('Enter chapter: ')

    try:
        moveFiles(sub,chap)
    except:
        print('Wrong subject/chapter')
        continue
    break

# goes until done
while True:
    if input('Done? ') == 'yes':
        try:
            removeFiles()
        except:
            print('failed to delete; do it manually')
        break
