public class Dinosaur{

  float x,y,closest,direction, closestFoe, closestFood,prevClosestFood, distanceMoved, index, stomache, energy, maxSpeed ,efficiency;
  DNA dna = new DNA();
  int neuralStart;

  Dinosaur(float x,float y, float i){

    this.x = x;
    this.y = y;
    this.closest = 999999;
    this.closestFood = 999999;
    this.prevClosestFood = 999999;
    this.distanceMoved = 0;
    this.closestFoe = 999999;
    this.direction = 0;
    this.index = i;
    this.stomache = 0;
    this.energy = 10;
    this.maxSpeed = dna.genes[0]+1.1;
    this.efficiency = 0.1;
    this.neuralStart = 2;
    // this.size = dna.genes[2];
    // this.red = dna.genes[2];
    // this.green = dna.genes[2];
    // this.blue = dna.genes[2];

  }
  public void update(ArrayList<Food> foods){
      Food[] arr = new Food[foods.size()];
      arr = foods.toArray(arr);
      this.update(arr) ;
  }
  public void update(Food foods[]){
    if(this.isAlive()){
      this.show();
      this.getFoodSmell(foods);
      this.decide(foods);
      this.digest();
      this.prevClosestFood = this.closestFood;
    }
  }
  //needs work
  private void decide(Food[] foods){
    //genes layout
    //bias as first value
    /* 
      number of hidden layers 1 - 3
      number of nodes in first layer 3-5
      number of nodes in second layer (disabled)
      ...
    first layer 4*5
      weight  1-1
      weight  1-2
      weight  1-3
      weight  1-4
      bias    1-1
      ...
      weight  5-1
      weight  5-2
      weight  5-3
      weight  5-4
      bias    5-1
    second layer 5*5
      weight  1-1
      weight  1-2
      ...
      weight  5-4
      weight  5-5
      bias    5-1
    third layer 5*5
      weight  1-1
      weight  1-2
      ...
      weight  5-5
      bias    5-1

    output layer 5*4
      weight  1-1
      weight  1-2
      ...
      weight  4-5
      bias    4-1

    */


    //neural net plan 
    /*
    ins:
      nearest smell
      last nearest smell
      direction facing
      distance moved

    outs:
      direction to face
      distance to move
      eat
      reproduce

    */
    
    int layers = 1+(int)((dna.genes[this.neuralStart]+1.0)*1.5) ;
    int layerOneNeruons = 3+(int)((dna.genes[this.neuralStart+1]+1.0)*1.5) ;
    int layerTwoNeruons = 3+(int)((this.dna.genes[this.neuralStart+2]+1.0)*1.5) ;
    int layerThreeNeruons = 3+(int)((this.dna.genes[this.neuralStart+3]+1.0)*1.5) ;

    float inputs[] = {this.closestFood,this.prevClosestFood, this.direction, this.distanceMoved };
    float outputs[] = new float[4];
    float layer1[] = new float[layerOneNeruons];
    float layer2[] = new float[layerTwoNeruons];
    float layer3[] = new float[layerTwoNeruons];

    int index = this.neuralStart+4;
    for(int i=0;i<layer1.length;i++){
      layer1[i] = this.dna.genes[index];
      index++;
      for(int j=0;j<inputs.length;j++){
        layer1[i] += this.dna.genes[index] * inputs[j];
        index++;
      }
      layer1[i] = activation(layer1[i]);
    }
    // if(layers == 1){
      for(int i=0;i<outputs.length;i++){
        outputs[i] = this.dna.genes[index];
        index++;
        for(int j=0;j<layer1.length;j++){
          outputs[i] += this.dna.genes[index] * layer1[j];
          index++;
        }
      }
    // }
    this.direction = outputs[0]*PI;
    float distance = max(min(outputs[1],1),0)*maxSpeed;
    if(outputs[2]>0.5){
      this.consume(foods);
    }


    this.move(this.direction, distance);

  }

  private float activation(float a){
    return max(0,a);
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
  public float getFoodSmell(Food plants[]){
    float smell = 0;
    for(int i=0;i<plants.length;i++){
      smell += plants[i].getSmell(this.x,this.y);
    }
    return smell;
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
    this.direction = angle;
    this.move(distance);
  }
  public void move(float distance){
    distance = min(this.maxSpeed, distance);
    this.x += distance * cos(this.direction);
    this.y += distance * sin(this.direction);
    this.energy-=distance/this.efficiency;
    this.distanceMoved=distance;
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