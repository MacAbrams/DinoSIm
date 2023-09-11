public class Dinosaur{

  float x,y,closest,direction, closestFoe, closestFood, index, stomache;

  
  Dinosaur(float x,float y, float i){
    this.x = x;
    this.y = y;
    this.closest = 999999;
    this.closestFood = 999999;
    this.closestFoe = 999999;
    this.direction = 0;
    this.index = i;
    this.stomache = 1;
  }
  public void update(ArrayList<Food> foods){
      Food[] arr = new Food[foods.size()];
      arr = foods.toArray(arr);
      this.update(arr) ;
  }
  public void update(Food foods[]){
    if(this.isAlive()){
      this.show();
      vec2 nav = this.navigate(foods);
      this.move(nav);
    }

  }

  private vec2 navigate(Food[] foods){

    float oldDistance = this.closest;
    float distance = this.getFoodDist(foods);
    if(distance>oldDistance){
      this.direction = random(TWO_PI);
    }

    return new vec2(this.direction,distance/2);
  }

  public void show(){
    fill(255,0,0);
    noStroke();
    circle(this.x,this.y, 10);
    stroke(255,0,0);
    strokeWeight(3);
    line(this.x,this.y,this.x+12*cos(this.direction),this.y+12*sin(this.direction));
    
  }
  
  public void consume(Food[] foods){
    int i = this.getClosestFood(foods);
    this.stomache += foods[i].eat();

  }

  public float getFoodDist(Food plants[]){
    this.closest = 999999;

    for(int i=0;i<plants.length;i++){
      float distance = plants[i].getDistance(this.x,this.y);
      this.closest = min(this.closest, distance);
    }
    return this.closest;
  }
  public int getClosestFood(Food plants[]){
    this.closest = 999999;
    int index=0;
    for(int i=0;i<plants.length;i++){
      float distance = plants[i].getDistance(this.x,this.y);
      if(this.closest>distance){
        this.closest = distance;
        index = i
      }
    }
    return index;
  }
  public void move(vec2 pol){
    this.x += pol.y * cos(pol.x);
    this.y += pol.y * sin(pol.x);
  }
  public void move(float angle,float distance){
    this.x += distance * cos(angle);
    this.y += distance * sin(angle);
  }

  public boolean isAlive(){
    if(this.stomache<=0){
      return false;
    }
    return true;
  }
  
}