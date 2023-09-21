public class Dinosaur{

  float x,y,closest,direction, closestFoe, closestFood, index, stomache, energy, maxSpeed ,efficiency;

  
  Dinosaur(float x,float y, float i){
    this.x = x;
    this.y = y;
    this.closest = 999999;
    this.closestFood = 999999;
    this.closestFoe = 999999;
    this.direction = 0;
    this.index = i;
    this.stomache = 0;
    this.energy = 10;
    this.maxSpeed = 1;
    this.efficiency = 10;
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
      this.consume(foods);
      this.digest();
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
    Food f = this.getClosestFood(foods);
    if(f.getDistance(this.x,this.y)<0.01){
      this.stomache += f.eat();
    }

  }

  public float getFoodDist(Food plants[]){
    this.closest = 999999;

    for(int i=0;i<plants.length;i++){
      float distance = plants[i].getDistance(this.x,this.y);
      this.closest = min(this.closest, distance);
    }
    return this.closest;
  }
  public Food getClosestFood(Food plants[]){
    float closest = 999999;
    int index=0;
    for(int i=0;i<plants.length;i++){
      float distance = plants[i].getDistance(this.x,this.y);
      if(closest>distance){
        closest = distance;
        index = i;
      }
    }
    return plants[index];
  }
  public void move(vec2 pol){
    this.move(pol.x,pol.y);
  }
  public void move(float angle,float distance){
    distance = min(this.maxSpeed, distance);
    this.x += distance * cos(angle);
    this.y += distance * sin(angle);
    this.energy-=distance/this.efficiency;
  }

  public boolean isAlive(){
    if(this.energy<=0){
      return false;
    }
    return true;
  }
  private void digest(){
    if(this.stomache>0){
    this.stomache-=1;
    }
    this.energy+=0.5;
  }

}