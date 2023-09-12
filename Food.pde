class Food{
  float x,y;
  boolean isAlive = true;
  Food(float x,float y){
    this.x = x;
    this.y = y;
  }
  
  public void show(){


    if(isAlive){
      fill(0,255,0);
      stroke(0);
      strokeWeight(1);
      circle(this.x, this.y, 10);

    }

  }
  
  public float getDistance(float x,float y){
    if(isAlive){
      return dist(this.x,this.y,x,y);
    }
    return 99999999;
  }
  public float eat(){
    if(isAlive){
      isAlive = false;
      return 1;

    }
    return 0;
  }
}