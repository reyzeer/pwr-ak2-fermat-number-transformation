#!/home/reyzeer/anaconda3/bin/python

import numpy as np
from skimage import io
from PIL import Image
import scipy.misc

text_file = open("imgout_vetor.txt", "r")
lines = text_file.read().split(';')
print lines

exit;


# Load image
img = io.imread('image.bmp')

# Monochromatic images
img = img[:,:,1]

# Image print as 2D vector
imgAsVector = ''
imgAsVector += '['
for rows in img:
    for column in rows:
        imgAsVector += str(column)
        imgAsVector += ','
    imgAsVector = imgAsVector[:-1]
    imgAsVector += ';'
imgAsVector = imgAsVector[:-1]
imgAsVector += ']'

print("%s" % (imgAsVector))

scipy.misc.imsave('outfile.jpg', image_array)

#print('[', end='')
#for rows in img:
#    for column in rows:
#        print(column, end='')
#        print(',', end='')
#    print('\b', end='')
#    print(';', end='')
#print('\b', end='')
#print(']', end='')

#newImg = Image.fromarray(img)
#newImg.save('out.bmp')

#for pixel in img:
#    print pixel
