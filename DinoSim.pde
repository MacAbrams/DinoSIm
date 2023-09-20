ArrayList<Dinosaur> dinos = new ArrayList<Dinosaur>();
ArrayList<Food> foods = new ArrayList<Food>();
PShader program;
float[][] foodPositions = new float[100][2];
public PImage data =createImage(100, 1, RGB);

void setup() {
  size(1000, 1000, P3D);
    program = loadShader("shader.frag");

  for(int i = 0; i<100; i++){


    dinos.add(new Dinosaur(random(width),random(height), i));
  }
  data.loadPixels();
  for(int i = 0; i<100; i++){
    float x = random(width);
    float y = random(height);
    foods.add(new Food(x,y));
    // data.set(i,1,color(x*256/width,y*256/height,0));
    data.pixels[i] = color(x*256/width,y*256/height,foods.get(i).growth);
    // foodPositions[i][0] = x;
    // foodPositions[i][1] = y;
  }
  System.out.println(Integer.toHexString(data.pixels[0]));

  data.updatePixels();
  
}

void draw() {
  background(0);
  // image(data, 0, 0, width, height);
  shader(program);
  program.set("foods", data);
  program.set("numFoods", 100);
  program.set("resolution", width,height);
  rect(0,0,width,height);
  resetShader();


  for(int i=0;i<foods.size();i++){
    foods.get(i).update();
  }
  
  for(int i = 0; i<dinos.size(); i++){
    dinos.get(i).update(foods);
    dinos.get(i).x = (dinos.get(i).x+width)%width;
    dinos.get(i).y = (dinos.get(i).y+height)%height;
  }
  
}