class Food{
  float x,y;
  Food(float x,float y){
    this.x = x;
    this.y = y;
  }
  
  public void show(){
    fill(0,255,0);
    stroke(0);
    strokeWeight(1);

    circle(this.x, this.y, 10);
  }
  
  public float getDistance(float x,float y){
    return dist(this.x,this.y,x,y);
  }
  
}