import cv2 as cv
import glob
import os
import uuid


def resizeImages(imageDirectory, returnDirectory, scalePercent):

    images = glob.glob(imageDirectory)
    count = 0
    
    for fname in images:
        count += 1
        img = cv.imread(fname)
        # This part of the code determines the new dimensions of our image
        width = int(img.shape[1] * scalePercent / 100)
        height = int(img.shape[0] * scalePercent / 100)
        dim = (width, height)
        # Resizes image based on dimension
        resized = cv.resize(img, dim, interpolation=cv.INTER_AREA)
        os.chdir(returnDirectory)
        imageName = '%s.png' % (count)
        cv.imwrite(imageName, resized)
    return
