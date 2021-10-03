//Create random seed values for every microtubule
seed = 2;
random("seed",seed);

title = getTitle();
lstr = lengthOf(title);
substr = lstr - 4;
mintif = substring(title, 0, substr);
new_title = mintif + "_randomised.tif";

run("Duplicate...", "duplicate");

total_slices = nSlices;
rename("base_image");

n = 0;
while (nSlices<total_slices+1) {
	seed_value = random;
	slices = nSlices;
	random_slice = slices * seed_value;
	if (n == total_slices-1) {
	run("Concatenate...", "  image1=stack image2=base_image image3=[-- None --]");		
	rename(new_title);
	} else if (random_slice >= 1) {	
		if (n == 0){
			setSlice(random_slice);
			run("Duplicate...", " ");
			rename("stack");
			selectImage("base_image");			
			run("Slice Remover", "first=random_slice last=random_slice increment=1");
		}
		if (n > 0){
			setSlice(random_slice);
			run("Duplicate...", " ");
			rename("new_slice");
			run("Concatenate...", "  image1=stack image2=new_slice image3=[-- None --]");
			selectImage("Untitled");
			rename("stack");
			selectImage("base_image");
			run("Slice Remover", "first=random_slice last=random_slice increment=1");
		}
	} else {
		total_slices += 1;
	}
	n += 1;
}



