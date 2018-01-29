dir = getDirectory("Choose source directory");
list = getFileList(dir);
dir1 = getDirectory("Choose destination directory for the masks");
dir2 = getDirectory("Choose destionation of the csv");
print(dir);
print(dir1);
print(dir2);
print(list.length);

for(i=0; i<list.length;i++){
    print(list[i]);
}
setBatchMode(true);
// empty the result table
run("Clear Results");
// define the set of measurement
run("Set Measurements...", "area mean standard modal min center perimeter bounding integrated display redirect=None decimal=3");

for(i=0; i<list.length;i++){
	file = list[i];
    open(dir + file);
    //wait(1000);
    //name = File.nameWithoutExtension();

    //make the image more robust and measure the area
    run("Enhance Contrast", "saturated=0.35");
    run("Apply LUT");
    run("Subtract Background...", "rolling=20");
    run("Median...", "radius=2");
    setAutoThreshold("Triangle dark");
    setOption("BlackBackground", false);
    run("Convert to Mask");
    run("Analyze Particles...", "size=30.00-Infinity circularity=0.00-0.38 show=Masks");
    run("Create Selection");
    run("Measure");

    //save the mask
    selectWindow(file);
    close();
    selectWindow("Mask of "+file);
    out_path = dir1 + file;
    print(out_path);
    saveAs("Tiff",out_path);
    
    //close the image to avoid overload of the ram
    close();
}
//save the csv with the measurement
saveAs("Results", dir2+"result_area.csv");

showMessage("Macro is finished");