boolean rotateL = false; 
boolean rotateR = false;
boolean accel = false;
boolean decell = false;
boolean hyper = false;
public double dX1,dX2,dY1,dY2;
boolean hyperspace = false;
SpaceShip wallace;
public int theFrame;
public void setup() 
{
  noStroke();
  size(800,800);
  background(0);
  wallace= new SpaceShip();
  dX1 = 400;
  dY1 = 400;
}
public void draw() 
{
  background(0);
  if (frameCount == theFrame+2)
  {
    hyperspace = false;
  }
  dX2 = wallace.getX();
  dY2 = wallace.getY();
  wallace.move();
  wallace.show();
  if (accel)
  {
    wallace.accelerate(0.2);
  }
  if (decell)
  {
    wallace.accelerate(-0.2);
  }
  if (rotateL)
  {
    wallace.rotate(4);
  }
  if (rotateR)
  {
    wallace.rotate(-4);
  }
  if (wallace.getX()>10 && wallace.getX()<790 && wallace.getY()>10 && wallace.getY()<790 && hyperspace == false)
  {
    wallace.setDirectionX(wallace.getDirectionX() - (dX2-dX1)/43);
    wallace.setDirectionY(wallace.getDirectionY() - (dY2-dY1)/43);
  }
  dX1 = dX2;
  dY1 = dY2;
}
public void keyPressed()
{
  if (key == 119)
  {
    accel = true;
  }
  if (key == 115)
  {
    decell = true;
  }
  if (key == 100)
  {
    rotateL = true;
  }
  if (key == 97)
  {
    rotateR = true;
  }
  if (key == 113 && hyper == false)
  {
    hyperspace = true;
    hyper = true;
    theFrame = frameCount;
    wallace.setDirectionX(0);
    wallace.setDirectionY(0);
    int c = (int)(Math.random()*360);
    wallace.setPointDirection(c);
    int a = (int)(Math.random()*700) +50;
    int b = (int)(Math.random()*700) +50;
    wallace.setX(a);
    wallace.setY(b);
  }
}
public void starfield()
{
  
}
public void keyReleased()
{
  if (key == 119)
  {
    accel = false;
  }
  if (key == 115)
  {
    decell = false;
  }
  if (key == 100)
  {
    rotateL = false;
  }
  if (key == 97)
  {
    rotateR = false;
  }
  if (key == 113)
  {
    hyper = false;
  }
  // if (key == 113)
  // {
  //   hyperspace = true;
  //   theFrame = frameCount;
  //   int a = (int)(Math.random()*700) +50;
  //   int b = (int)(Math.random()*700) +50;
  //   wallace.setX(a);
  //   wallace.setY(b);
  // }
}
class SpaceShip extends Floater  
{ 
  public SpaceShip()
  {
    corners = 14;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -10;
    yCorners[0] = -26;
    xCorners[1] = -10;
    yCorners[1] = -8;
    xCorners[2] = -18;
    yCorners[2] = 0;
    xCorners[3] = -10;
    yCorners[3] = 8;
    xCorners[4] = -10;
    yCorners[4] = 26;
    xCorners[5] = 10;
    yCorners[5] = 14;
    xCorners[6] = 10;
    yCorners[6] = 10;
    xCorners[7] = 14;
    yCorners[7] = 8;
    xCorners[8] = 14;
    yCorners[8] = 4;
    xCorners[9] = 22;
    yCorners[9] = 0;
    xCorners[10] = 14;
    yCorners[10] = -4;
    xCorners[11] = 14;
    yCorners[11] = -8;
    xCorners[12] = 10;
    yCorners[12] = -10;
    xCorners[13] = 10;
    yCorners[13] = -14;
    myColor = 255;
    myCenterX = 400;
    myCenterY = 400;
    myDirectionX = 0;
    myDirectionY = 0;
    myPointDirection = 0;
  }
  public void setX(int x) {myCenterX = x;}
  public int getX() {return (int)myCenterX;}
  public void setY(int y) {myCenterY = y;}
  public int getY() {return (int)myCenterY;}
  public void setDirectionX(double x) {myDirectionX = x;}
  public double getDirectionX() {return myDirectionX;}
  public void setDirectionY(double y) {myDirectionY = y;}
  public double getDirectionY() {return myDirectionY;}
  public void setPointDirection(int degrees) {myPointDirection = degrees;}
  public double getPointDirection() {return myPointDirection;}
}
abstract class Floater //Do NOT modify the Floater class! Make changes in the SpaceShip class 
{   
  protected int corners;  //the number of corners, a triangular floater has 3   
  protected int[] xCorners;   
  protected int[] yCorners;   
  protected int myColor;   
  protected double myCenterX, myCenterY; //holds center coordinates   
  protected double myDirectionX, myDirectionY; //holds x and y coordinates of the vector for direction of travel   
  protected double myPointDirection; //holds current direction the ship is pointing in degrees    
  abstract public void setX(int x);  
  abstract public int getX();   
  abstract public void setY(int y);   
  abstract public int getY();   
  abstract public void setDirectionX(double x);   
  abstract public double getDirectionX();   
  abstract public void setDirectionY(double y);   
  abstract public double getDirectionY();   
  abstract public void setPointDirection(int degrees);   
  abstract public double getPointDirection(); 

  //Accelerates the floater in the direction it is pointing (myPointDirection)   
  public void accelerate (double dAmount)   
  {
    //convert the current direction the floater is pointing to radians    
    double dRadians =myPointDirection*(Math.PI/180);     
    //change coordinates of direction of travel    
    myDirectionX += ((dAmount) * Math.cos(dRadians));    
    myDirectionY += ((dAmount) * Math.sin(dRadians));  
  }   
  public void rotate (int nDegreesOfRotation)   
  {     
    //rotates the floater by a given number of degrees    
    myPointDirection+=nDegreesOfRotation;   
  }   
  public void move ()   //move the floater in the current direction of travel
  {      
    //change the x and y coordinates by myDirectionX and myDirectionY       
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;     
    //System.out.println(myCenterX);
    //System.out.println(myCenterY);
    //wrap around screen    
    if(myCenterX >width)
    {     
      myCenterX = 0;    
    }    
    else if (myCenterX<0)
    {     
      myCenterX = width;    
    }    
    if(myCenterY >height)
    {    
      myCenterY = 0;    
    }   
    else if (myCenterY < 0)
    {     
      myCenterY = height;    
    }   
  }   
  public void show ()  //Draws the floater at the current position  
  {             
    fill(myColor);   
    stroke(myColor);    
    //convert degrees to radians for sin and cos         
    double dRadians = myPointDirection*(Math.PI/180);                 
    int xRotatedTranslated, yRotatedTranslated;    
    beginShape();         
    for(int nI = 0; nI < corners; nI++)    
    {     
      //rotate and translate the coordinates of the floater using current direction 
      xRotatedTranslated = (int)((xCorners[nI]* Math.cos(dRadians)) - (yCorners[nI] * Math.sin(dRadians))+myCenterX);     
      yRotatedTranslated = (int)((xCorners[nI]* Math.sin(dRadians)) + (yCorners[nI] * Math.cos(dRadians))+myCenterY);  
      // System.out.println(xRotatedTranslated);
      // System.out.println(yRotatedTranslated);
      vertex(xRotatedTranslated,yRotatedTranslated);    
    }   
    endShape(CLOSE);  
  }   
} 

