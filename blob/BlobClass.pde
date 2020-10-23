class BlobClass {
  float xAdd;
  float yAdd;
  float cChanger;
  float size;
  float radius;
  boolean screenWasCleared;
  PShape c;
  PImage img;


  //constructor
  BlobClass(float xPos, float yPos, float cChngr) {
    
    noStroke();
    fill(101, 255, 0);
    
    //initialize values
    xAdd=xPos;
    yAdd=yPos;
    cChanger=cChngr;
    screenWasCleared=false;


    c=createShape();
    c.beginShape();

    for (float i=-TWO_PI; i<TWO_PI; i+=0.8) { //draws a vertex every 0.8 pixels on the screen in the shape of a circle
 
      radius=150;
      float  x=cos(i)*radius+width/2;  //used equation of a circle
      float y=sin(i)*radius+height/2;

      c.vertex(x, y);
    }

    c.endShape();
  }

  void display(long size) {
    //makes slime glow in the dark

    if (key=='p') {
      randomSeed(size); //filters random so its the same random value. This way slime isnt flashing so much
      c.setFill( color(random(cChanger, 255), 255, 0, random(cChanger, 255)));  //makes slime go from green to yellow and changes transparency
    }

    shape(c);
  }

  //accessing all the vertecies in PShape and thenn sets them to a random value from a range selected by the x and y position of blobs
  void wiggle(float xChange, float  yChange) {

    for (int i = 0; i < c.getVertexCount(); i++) {
      PVector v = c.getVertex(i);

      v.x+=random(-xChange/150, xChange/150);  //value was large so dividing by 150
      v.y+=random(-yChange/150, yChange/150);  ////value was large so dividing by 150

      c.setVertex(i, v.x, v.y);

      if (v.x<10 || v.x>width-10) {    //check boundaries. If slime grows off the screen then set boolean to true
        screenWasCleared=true;
      }
    }
  }

  int clearScreen() {  //used in main function to know if slime is too big
    if (screenWasCleared==true) {
      return 1;
    } else return 0;
  }
}
