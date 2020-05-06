import numpy as np
import cv2 as cv
import glob
import os

# Checking that OpenCV is installed... Important step...
print(cv.__version__)

# Resizing the photos to optimize the calibration step. This is something we had
# to do for our iPhone photos.

directory = 'C:/Users/paulf/Documents/GitHub/Computational-Dynamics/Project'

os.chdir(directory)
from resizeImages import resizeImages

imageDirectory = 'C:/Users/paulf/Documents/GitHub/Computational-Dynamics/Project/iPhone Photos/*.jpg'
returnDirectory = 'C:/Users/paulf/Documents/GitHub/Computational-Dynamics/Project/Project Photos'
scalePercent = 50
resizeImages(imageDirectory, returnDirectory, scalePercent)


# Pulling photos from the Edgertronic Cameras
edgerPhotos = 'C:/Users/paulf/Documents/Github/Computational-Dynamics/Project/Edgertronic Photos/*.png'

# 3D Points are called object points & 2D image points are called image points
# at least this is the OpenCV convention and seems to make the most sense.
# Working through the OpenCV documentation for camera calibration we can
# try and analysis some pictures we took earlier in the semester.

# The documentation seems to recommend termination conditions
criteria = (cv.TERM_CRITERIA_EPS + cv.TERM_CRITERIA_MAX_ITER, 30, 0.001)

# Preparing an object points array we will try and focus on a checkerboard
# of size 5x5.
objp = np.zeros((5*5, 3), np.float32)
objp[:, :2] = np.mgrid[0:5, 0:5].T.reshape(-1, 2)

# Making arrays to store the image points and object points from our image
objpoints = []
imgpoints = []

# newDirectory = 'C:/Users/paulf/Documents/GitHub/Computational-Dynamics/Project/Project Photos/*.png'
images = glob.glob(edgerPhotos)
usableImage = 0

for fname in images:
    img = cv.imread(fname)

    # This changes the image to a greyscale image, however, we already are
    # using monochromatic cameras (everything should be in greyscale) but
    # it won't run without this bit. I suspect that there are specific
    # shade values for each pixel expected in some of the following commands
    # which makes it important to still convert the images to what is expected
    # by OpenCV. Just something interesting that I came across.
    gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

# Finding the checkerboard corners

    ret, corners = cv.findChessboardCorners(gray, (5, 5), None)
# Adding object points when corners are found
    if ret == True:
        usableImage += 1
        objpoints.append(objp)

        corners2 = cv.cornerSubPix(gray, corners, (11, 11), (-1, -1), criteria)
        imgpoints. append(corners)

        # Displaying the corners on the last image that worked
        cv.drawChessboardCorners(img, (5, 5), corners2, ret)
        cv.imshow('img', img)
        cv.waitKey(0)
        cv.destroyAllWindows()

# We will want to know the number of usable images to determine if we need more
# photos to calibrate the camera.
print(usableImage)

# Now we want to actually gather the intrinsic/extrinsic values of our camera.
# The intrinsic values have to do with the camera sensor itself. While
# the extrinsic values have to do with the positioning of the camera which'
# is important for creating a 3D coordinate system. We will determine these
# values or parameters by using the OpenCV camera calibration software.

ret, mtx, dist, rvecs, tvecs = cv.calibrateCamera(
    objpoints, imgpoints, gray.shape[::-1], None, None
    )

# We can now undistort the image given these parameters
imageToUndistort = 'C:/Users/paulf/Documents/GitHub/Computational-Dynamics/Project/Edgertronic Photos/1.png'
img = cv.imread(imageToUndistort)
h, w = img.shape[:2]
newcameramtx, roi = cv.getOptimalNewCameraMatrix(mtx, dist, (w, h), 1, (w, h))

# The undistort process
dst = cv.undistort(img, mtx, dist, None, newcameramtx)

# Cropping the image
x, y, w, h = roi
dst = dst[y:y+h, x:x+w]
cv.imwrite('calibratedresult.png', dst)

# We can compare the two images and see what changed
cv.imshow('image', dst)
img = cv.imread(imageToUndistort)
cv.imshow('previmage', img)
cv.waitKey(0)
cv.destroyAllWindows()
# In this picture the resulting image is cropped to be slightly smaller. There
# aren't any obvious changes otherwise, but the image was already clear and the
# edges were straight. Not all images would be like this and it's important
# to make sure that your images are as clear and undistorted as possible before
# you start to get further into image processing.

# Finding the corners of an image we know previously worked
img = cv.imread('C:/Users/paulf/Documents/GitHub/Computational-Dynamics/Project/Edgertronic Photos/19.png')
gray = cv.cvtColor(img, cv.COLOR_BGR2GRAY)

# Finding the checkerboard corners
ret, corners = cv.findChessboardCorners(gray, (5, 5), None)
# If ret is true then we found corners of the chessboard
ret
corners2 = cv.cornerSubPix(gray, corners, (11,11), (-1,-1), criteria)

# Find the rotation and translation vectors.
ret, rvecs, tvecs = cv.solvePnP(objp, corners2, mtx, dist)

# Making our axis and resulting lines three checkerboard spaces long
axis = np.float32([[3, 0, 0], [0, 3, 0], [0, 0, -3]]).reshape(-1, 3)

# Project 3D points to image plane
imgpts, jac = cv.projectPoints(axis, rvecs, tvecs, mtx, dist)

# Drawing lines on our chessboard.
corner = tuple(corners2[0].ravel())
img = cv.line(img, corner, tuple(imgpts[0].ravel()), (255, 0, 0), 5)
img = cv.line(img, corner, tuple(imgpts[1].ravel()), (0, 255, 0), 5)
img = cv.line(img, corner, tuple(imgpts[2].ravel()), (0, 0, 255), 5)

# Displays the final result
cv.imshow('img', img)
k = cv.waitKey(0)
cv.destroyAllWindows()
