//create a new image
newImage("Untitled", "8-bit white", 512, 512, 1);
//set the background color
setForegroundColor(0, 0, 0);
//make and draw a line
makeLine(100, 0, 100, 512);
run("Draw", "slice");
//make and draw the second line
makeLine(256, 0, 256, 512);
run("Draw", "slice");
//make and draw the third line
makeLine(412, 0, 412, 512);
run("Draw", "slice");
// remove the selections
run("Select None");