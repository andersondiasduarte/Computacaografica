void setup() { 
  size(800, 800); 
  noLoop(); 
}

void draw() {
   PImage imgOrig = loadImage("black_dog_resized.png");
   PImage imgTrain = loadImage("black_dog_segmented.jpg"); 
   PImage imgGroundTrue = loadImage("black_dog_GroundTrue.jpg"); 
   PImage imgFinal = createImage(imgOrig.width, imgOrig.height, RGB); 
   int acc_error = 0;
   float mae = 0;
   int tp = 0;
   int tn = 0;
   int fp = 0;
   int fn = 0;

   for (int y = 0; y < imgTrain.height; y++) {
    for (int x = 0; x < imgTrain.width; x++) {
      int pos = (y)*imgTrain.width + (x); 
      if(red(imgTrain.pixels[pos]) != 0){
        imgFinal.pixels[pos] = color(red(imgOrig.pixels[pos]),green(imgOrig.pixels[pos]),blue(imgOrig.pixels[pos]));
      } else{
        imgFinal.pixels[pos] = color(0);
      }
      int error_pixel = int(red(imgTrain.pixels[pos]) - red(imgGroundTrue.pixels[pos]));
      if(red(imgTrain.pixels[pos]) != 0 && red(imgGroundTrue.pixels[pos]) == 0) fp += 1;
      if(red(imgTrain.pixels[pos]) == 0 && red(imgGroundTrue.pixels[pos]) != 0) fn += 1;
      if(red(imgTrain.pixels[pos]) == 0 && red(imgGroundTrue.pixels[pos]) == 0) tn += 1;
      if(red(imgTrain.pixels[pos]) != 0 && red(imgGroundTrue.pixels[pos]) != 0) tp += 1;
      if (error_pixel != 0) acc_error += 1;
    }
   }
   
   float total_pixel = imgTrain.width * imgTrain.height;
   mae = acc_error/total_pixel;
   float ttp = tp/total_pixel;
   float ttn = tn/total_pixel;
   float tfp = fp/total_pixel;
   float tfn = fn/total_pixel;
   
   println("Confusion Matrix");
   println("              True Predicted            False Predicted");
   print("True Real      ", ttp);
   println("               ",tfp);
   print("False Real      ", tfn);
   println("               ",ttn);
   
  //image(imgFinal, 0, 0); 
  //save("imgFinal.jpg");
  image(imgOrig, 0, 0);
  image(imgGroundTrue, 900, 0);
  image(imgTrain, 1800, 0);
  image(imgFinal, 2700, 0);
  save("resultFinal_blackDog.jpg");
}
