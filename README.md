## Processing Newton's Method

This code generates a sequence of images using Newton's method
to find the roots of the following equation `x ^ 4 - 1 + x ^ 3`

Feel free to play around with the equations and colors of the sketch! I have pre-define some nice color palettes for the basin fill. I prefer the blue theme myself. 

![iterations](https://github.com/alazareva/newtons_method/blob/master/examples/iterations.jpeg)

Controls:
`key 'b' or 'B' to toggle between drawing basins/iterations'
`key 'r' or 'R' to save frames`

Note: this thing is slow! It's iterating up to 100 times per pixel, if you want to speed it up, make the canvas smaller.