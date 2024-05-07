void setup() { 
  size(900, 900); 
  noLoop(); 
}

void draw() {
  PImage imgOriginal = loadImage("german_shorthaired_126.jpg"); 
  PImage imgSegmentada = loadImage("seg.jpg");
  
  imgSegmentada.resize(imgOriginal.width, imgOriginal.height);
  
  imgOriginal.loadPixels();
  imgSegmentada.loadPixels();
  
  PImage novaImg = createImage(imgOriginal.width, imgOriginal.height, RGB);
  
  for (int y = 0; y < imgOriginal.height; y++) {
    for (int x = 0; x < imgOriginal.width; x++) { 
      int pos = y * imgOriginal.width + x; 
      
      if (brightness(imgSegmentada.pixels[pos]) == 255) {
        novaImg.pixels[pos] = imgOriginal.pixels[pos];
      } else {
        novaImg.pixels[pos] = color(0);
      }
    }
  }
  
  novaImg.updatePixels();
  
  image(novaImg, 0, 0); 
  
  save("FinalResult.jpg"); 
}
