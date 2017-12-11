# COMP 317 - Final Project
A convolutional neural net that classifies images into two categories: corgis or bread.

Inside this zip file, you will find:
* (**Constants.m**) A file with constants that are used throughout the project.
* (**preprocessImages.m**) A file that resizes images and catches corrupted/non-RBG images.
* (**setupCNN.m**) A file that setups the convolutional neural network.
* (**displayMislabeledImages.m**) A file that creates a figure of the first 100 mislabeled images.
* (**CorgiBreadClassifier.m**) And *finally*, a script that runs everything up above!

To build this project, please fill in your directory constant (in **Constants.m**) where you downloaded this zip file/where the data can be found on your computer. Then, replace the root_folder variable on line 2 (in **CorgiBreadClassifier.m**) with your newly created constant. From here, all you have to do is run CorgiBreadClassifier.m!

The script will train a CNN, outputting its accuracy and displaying the first 100 mislabeled images.

Enjoy,
Emily and Steph 🎉
