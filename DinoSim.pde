ArrayList<Dinosaur> dinos = new ArrayList<Dinosaur>();
ArrayList<Food> foods = new ArrayList<Food>();

void setup() {
  size(1000, 1000);
  for(int i = 0; i<100; i++){


    dinos.add(new Dinosaur(random(width),random(height), i));
  }
  
  for(int i = 0; i<100; i++){
    foods.add(new Food(random(width),random(height)));
  }
  
}

void draw() {
  background(220);
  for(int i=0;i<foods.size();i++){
    foods.get(i).show();
  }
  
  for(int i = 0; i<dinos.size(); i++){
    dinos.get(i).update(foods);
  }
  
}