class Food{
  float x,y, growth;
  long sTime;
  boolean isAlive = true;
  Food(float x,float y){
    this.x = x;
    this.y = y;
    this.sTime = millis();
  }
  
  public void update(){
    if(this.isAlive){
      // this.show();
    }
  }

  public vec2 getPosition(){
    return new vec2(this.x,this.y);
  }

  public void show(){


      fill(0,255,0);
      stroke(0);
      strokeWeight(1);
      circle(this.x, this.y, 10);


  }
  
  public float getDistance(float x,float y){
    if(isAlive){
      return dist(this.x,this.y,x,y);
    }
    return 99999999;
  }

  public float getSmell(float x,float y){
    float distance = this.getDistance(x,y);
    return this.growth/distance;
  }
  public float eat(){
    if(isAlive){
      // isAlive = false;
      float t = this.growth;

      this.growth = 0;
      return t;

    }
    return 0;
  }
}