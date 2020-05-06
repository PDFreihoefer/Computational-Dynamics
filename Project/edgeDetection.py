from cv2 import cv2
import numpy as np

# convert picture to matrix
image = cv2.imread("C:/Users/paulf/Documents/GitHub/Computational-Dynamics/Project/Presentation Images/bugs.jpg")

# show the picture
cv2.imshow('Bugs',image)

# choose ow long to show the picture
cv2.waitKey(1000)
cv2.destroyAllWindows()

# cropping the picture to show only the bug with good wings
# find the height and width
height,width = image.shape[0:2]

# crops based off the percentage you want cropped
startRow = int(height*.15)
startCol = int(width*.5)
endRow = int(height*.85)
endCol = int(width*.85)
cropimage = image[startRow:endRow, startCol:endCol]
cv2.imshow('Cropped Bugs', cropimage)
cv2.waitKey(1000)
cv2.destroyAllWindows()

# reduce the noise from the background
newbug = cv2.fastNlMeansDenoisingColored(cropimage, None, 9, 10, 7, 21)
cv2.imshow("Reduced Noise", newbug)
cv2.waitKey(1000)
cv2.destroyAllWindows()

# use Canny edge detector, an edge detector algorithm
# the values are the minimum and maximum intensity gradient values
edgeimage = cv2.Canny(newbug, 150, 500)
cv2.imshow("Edges", edgeimage)
cv2.waitKey(1000)
