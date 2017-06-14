
# coding: utf-8

# In[1]:

import matplotlib.pyplot as plt
import os
plt.rcParams.update({
    'image.cmap': 'gray',
    'figure.dpi': 120,
    'axes.grid': False,
})


# In[2]:

from skimage import data
from skimage.color import rgb2gray

# Load image
img_orginal = data.imread('image.bmp')
img = rgb2gray(img_orginal)

fig, axs = plt.subplots(1,2,figsize = (2,2))
axs[0].imshow(img_orginal)
axs[1].imshow(img)
plt.show()


# In[3]:

# Monochromatic images
# img = img[:,:,1]

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

text_file = open("imgin_vector.txt", "w")
text_file.write("%s" % imgAsVector)
text_file.close()


# In[4]:

try:
    os.remove("imginfnt_vector.txt")
except OSError:
    pass

try:
    os.remove("imgout_vector.txt")
except OSError:
    pass

import subprocess
test = subprocess.Popen(["gp", "-q", "fnt_2d_methods.gp"], stdout=subprocess.PIPE)
output = test.communicate()[0]
output


# In[5]:

with open("imgout_vector.txt") as file:
    data = file.read().replace('\n', '')


# In[6]:

import numpy
newImageArr = numpy.zeros((32,32))
i=0
for row in data[1:-1].split(';'):
    newImageArr[i] = row.split(',')
    i += 1


# In[7]:

fig, axs = plt.subplots(1,2,figsize = (2,2))
axs[0].imshow(img_orginal)
axs[1].imshow(newImageArr)
plt.show()

