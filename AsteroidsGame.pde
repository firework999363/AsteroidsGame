public int lives = 5;
//boolean control movement
boolean rotateL = false; 
boolean rotateR = false;
boolean accel = false;
boolean decell = false;
boolean hyper = false;
boolean shooting = false;
//to control effects cuz it is sorta distracting
boolean sparkles = true;
//boolean to leave instruction page
boolean startGame = false;
public double dX1,dX2,dY1,dY2;
boolean hyperspace = false;
ArrayList <Asteroid> spaceRock = new ArrayList <Asteroid>();
Starfield[] stars;
SpaceShip wallace;
ArrayList <Bullet> pewpew = new ArrayList <Bullet>();
public int theFrame;
public void setup() 
{
  noStroke();
  smooth();
  size(800,800);
  background(0,173,198);
  stars = new Starfield[150];
  for (int i=0; i< stars.length; i++)
  {
    stars[i] = new Starfield();
  }
  for(int i=1; i<15; i++)
  {
    spaceRock.add(new Asteroid());
  }
  wallace= new SpaceShip();
  dX1 = 400;
  dY1 = 400;
}
public void draw() 
{
  if (startGame == false){instructions();}
  else{playGame();}
}
public void playGame()
{
  background(0);
  for (int i=0; i< stars.length; i++)
  {
    stars[i].show();
  }
  if (wallace.getDirectionX()>12)
  {
    wallace.setDirectionX(10);
  }
  if (wallace.getDirectionX()<-12)
  {
    wallace.setDirectionX(-10);
  }
  if (wallace.getDirectionY()>12)
  {
    wallace.setDirectionY(10);
  }
  if (wallace.getDirectionY()<-12)
  {
    wallace.setDirectionY(-10);
  }
  if (frameCount == theFrame+2)
  {
    hyperspace = false;
  }
  if (shooting == true)
  {
    pewpew.add(new Bullet(wallace));
  }
  for(int i= 1; i<pewpew.size(); i++)
  {
    pewpew.get(i).move();
    pewpew.get(i).show();
  }
  dX2 = wallace.getX();
  dY2 = wallace.getY();
  for(int i= 1; i<spaceRock.size(); i++)
  {
    spaceRock.get(i).move();
    spaceRock.get(i).show();
    for(int k = 1; k<pewpew.size(); k++)
    {
      if (dist(spaceRock.get(i).getX(),spaceRock.get(i).getY(),wallace.getX(),wallace.getY()) < 35)
    {
      lives = lives -1;
      break;
    }
      if (dist(spaceRock.get(i).getX(),spaceRock.get(i).getY(),pewpew.get(k).getX(),pewpew.get(k).getY()) < 25)
      {
        spaceRock.remove(i);
        pewpew.remove(k);
        break;
      }
    }
  }
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
    wallace.rotate(5);
  }
  if (rotateR)
  {
    wallace.rotate(-5);
  }
  if (wallace.getX()>10 && wallace.getX()<790 && wallace.getY()>10 && wallace.getY()<790 && hyperspace == false)
  {
    wallace.setDirectionX(wallace.getDirectionX() - (dX2-dX1)/33);
    wallace.setDirectionY(wallace.getDirectionY() - (dY2-dY1)/33);
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
  if (key == 116)
  {
    sparkles = !sparkles;
  }
  if (key == 32)
  {
    if (startGame == false)
    {
      startGame = true;
    }
    shooting = true;
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
  if (key == 32)
  {
    shooting = false;
  }
}
// public void keyTyped()
// {
//   if (key == 32)
//   {
//     shooting = true;
//   } 
// }
class Starfield
{
  float s;
  float x;
  float y;
  public Starfield()
  {
    noStroke();
    s = (float)(Math.random()*8)+1.8;
    x = (float)Math.random()*800;
    y = (float)Math.random()*800;
  }
  public void show()
  { 
    if (frameCount%3 == 0 && sparkles == true)
    {
      int temp = (int)(Math.random()*205)+50;
      fill(temp, temp, temp-50);
    }
    else
    {
      fill(130,105,0);
    }
    beginShape();
    vertex((20.0/s)+x,(0.0/s)+y);
    bezierVertex((15.0/s)+x, (25.0/s)+y, (15.0/s)+x, (25.0/s)+y, (0.0/s)+x, (30.0/s)+y);
    vertex((0.0/s)+x,(30.0/s)+y);
    bezierVertex((15.0/s)+x, (35.0/s)+y, (15.0/s)+x, (35.0/s)+y, (20.0/s)+x, (60.0/s)+y);
    vertex((20.0/s)+x,(60.0/s)+y);
    bezierVertex((25.0/s)+x, (35.0/s)+y, (25.0/s)+x, (35.0/s)+y, (40.0/s)+x, (30.0/s)+y);
    vertex((40.0/s)+x,(30.0/s)+y);
    bezierVertex((25.0/s)+x, (25.0/s)+y, (25.0/s)+x, (25.0/s)+y, (20.0/s)+x, (0.0/s)+y);
    endShape();
  }
}
class Bullet extends Floater
{
  public Bullet(SpaceShip theShip)
  {
    myCenterX = wallace.getX();
    myCenterY = wallace.getY();
    myPointDirection = wallace.getPointDirection();
    double dRadians =myPointDirection*(Math.PI/180);
    myDirectionX = 5 * Math.cos(dRadians) + (wallace.getDirectionX());
    myDirectionY = 5 * Math.sin(dRadians) + (wallace.getDirectionY());
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
  public void show()
  {
    fill(255);
    ellipse((float)myCenterX,(float)myCenterY,8,8);
  }
  public void move ()   //move the floater in the current direction of travel
  {
    myCenterX += myDirectionX;    
    myCenterY += myDirectionY;
  } 
}
class Asteroid extends Floater 
{
  private int myRotation;
  public Asteroid()
  {
    corners = 11;
    xCorners = new int[corners];
    yCorners = new int[corners];
    xCorners[0] = -2;
    yCorners[0] = 9;
    xCorners[1] = 4;
    yCorners[1] = 17;
    xCorners[2] = 17;
    yCorners[2] = 4;
    xCorners[3] = 21;
    yCorners[3] = 3;
    xCorners[4] = 24;
    yCorners[4] = -8;
    xCorners[5] = 15;
    yCorners[5] = -24;
    xCorners[6] = 1;
    yCorners[6] = -17;
    xCorners[7] = -16;
    yCorners[7] = -22;
    xCorners[8] = -28;
    yCorners[8] = -3;
    xCorners[9] = -20;
    yCorners[9] = 17;
    xCorners[10] = -6;
    yCorners[10] = 20;
    myColor = 200;
    setX((int)(Math.random()*800));
    setY((int)(Math.random()*800));
    setDirectionX((int)(Math.random()*4)-2);
    setDirectionY((int)(Math.random()*4)-2);
    setPointDirection(0);
    myRotation=((int)(Math.random()*6)-3);
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
  public void move()
  {
    rotate(myRotation);
    super.move();
    if(myCenterX>-1)
    {
      myCenterX=myCenterX+2;
      myCenterY++;
    }
  }
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
    noStroke();  
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
public void instructions()
{
  fill(255);
  rect(355,100,90,90,15);
  rect(355,200,90,90,15);
  rect(455,200,90,90,15);
  rect(255,200,90,90,15);
  rect(285,400,90,90,15);
  rect(425,400,90,90,15);
  textSize(40);
  fill(0);
  text("W", 383, 145);
  text("S", 386, 245);
  text("D", 483, 245);
  text("A", 283, 245);
  text("Q", 313, 445);
  text("T", 456, 445);
  textSize(16);
  text("FORWARD", 360, 170);
  text("RIGHT", 476, 270);
  text("LEFT", 277, 270);
  text("WARP", 305, 470);
  textSize(10);
  text("TOGGLE EFFECTS", 430, 470);
  text("BACKWARDS", 365, 270);
  if ((mouseX>300) && (mouseX<500) && (mouseY>730) && (mouseY<780))
  {
    fill(140);
    if(mouseButton == LEFT)
    {
      fill(100);
    }
  }
  else{fill(180);}
  rect(300,730,200,50);
  textSize(40);
  fill(0);
  text("START",340,770);
}
void mouseReleased()
{
  if ((mouseX>300) && (mouseX<500) && (mouseY>730) && (mouseY<780))
  {
    startGame = true;
  }
}