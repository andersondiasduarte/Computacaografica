void setup() { 
  size(900, 900); 
  noLoop(); 
}

void draw() {
  PImage img = loadImage("english_cocker_spaniel_69_ resized.jpg"); 
  PImage imgPB = createImage(img.width, img.height, RGB); 
  PImage seg1 = createImage(img.width, img.height, RGB);
  PImage seg2 = createImage(img.width, img.height, RGB);
  PImage seg = createImage(img.width, img.height, RGB);
  
  // Filtro escala de cinza 
  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int pos = (y)*img.width + (x); 
      float media = green(img.pixels[pos]);
      imgPB.pixels[pos] = color(media);
    }
  }
  
  image(imgPB, 0, 0); 
  save("imgPB.jpg");



  for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int pos = (y)*img.width + (x); 
       if(green(imgPB.pixels[pos]) < 220) seg1.pixels[pos] = color(255);
       else seg1.pixels[pos] = color(0);
    }
  }
  
  image(seg1, 0, 0); 
  save("seg1.jpg");
  
  
 for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int pos = (y)*img.width + (x); 
       if(green(imgPB.pixels[pos]) < 155) seg2.pixels[pos] = color(255);
       else seg2.pixels[pos] = color(0);
    }
  }


  image(seg2, 0, 0); 
  save("seg2.jpg");
 
   for (int y = 0; y < img.height; y++) {
    for (int x = 0; x < img.width; x++) { 
      int pos = (y)*img.width + (x); 
       if(red(seg2.pixels[pos]) == 255 && x > 100 && y > 150 && x < img.width - 50) {
        seg.pixels[pos] = color(255);
      } else {
        seg.pixels[pos] = color(0); 
      }
    }
  }

}
