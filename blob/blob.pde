
//blob adapted from https://processing.org/tutorials/pshape/
//sound from freesound.org, created by:Goran Andrić-Agi zagi2 
//https://freesound.org/people/zagi2/sounds/223006/
import netP5.*;
import oscP5.*;
import processing.sound.*;

BlobClass blb;
SoundFile file;
int count;
float x;
float y;
float cChnger;
float size;
int si;
int state;
int yTop;
int yTopT;
int yBottom;
int yBottomT;
int eWidth1;
int eWidth2;
int eHeight;
int lX1;
int lX2;
int lX3;
int lX4;

final String BLOB_OSCADDRESS = "/MakeItArt/Blobs";
final String COLOR_OSCADDRESS = "/MakeItArt/Color";
final String GLOW_OSCADDRESS = "/MakeItArt/Glow";

//The port we are listening to... MUST match DESTPORT in the C++ example 
final int LISTENING_PORT = 8888;


OscP5 oscP5; //the object that will send OSC
NetAddress remoteLocation;

void setup() {
  size(800, 800);
  oscP5 = new OscP5(this, LISTENING_PORT);  //set up OSC port
  blb = new BlobClass(0, 0, cChnger);  //create blob
 
  file=new SoundFile(this,"funSong.wav");  //add song and play on a loop
  file.play();
  file.loop();
  
  //initializes values
  state=0;
  yTop=height/2-200;
  yTopT=height/2-220;
  yBottom=height/2-200;
  yBottomT=height/2+200;
  eWidth1=400;
  eWidth2=250;
  eHeight=30;
  lX1=width/2-200;
  lX2=width/2+200;
  lX3=width/2-175;
  lX4=width/2+175;
}

void oscEvent(OscMessage msg)
{
  String addr = msg.addrPattern(); //get the address
  int numberOfParamsPerMessage = 4; //change this number depending on how many features you send per blob

  //gets blob information and uses this to affect wiggle of blob
  if ( addr.equals(BLOB_OSCADDRESS) )
  {

    for (int i=0; i<msg.arguments().length; i+=numberOfParamsPerMessage)
    {
      float id = msg.get(i).floatValue(); 
      x =  msg.get(i+1).floatValue(); 
      y =  msg.get(i+2).floatValue();

      //your built-in sanity check. 
      // println(id+","+x +"x" +"'"+ y);
    }

  }
  //gets velocity from xCode and uses it to change opacity and color of blob
  if ( addr.equals(COLOR_OSCADDRESS) ) {
    cChnger=msg.get(0).floatValue();
  }
  
  //gets size of keypoint vector from xCode and uses it to change random seed of blob
  if ( addr.equals(GLOW_OSCADDRESS) ) {
    size=msg.get(0).floatValue();
    float toss=msg.get(1).floatValue();  //this value isnt used
  }
}


void draw() {
  
  //switch between screens
  switch(state) {
  case 0:
    doEverything();
    break;
  case 1:
    doPlay();
    break;
  case 2:
   restart();
  }
}

//setup screen with container
void doEverything() {
  clear();
  background(177, 156, 217);
  fill(255);
  textSize(32);
  text("press 'q' to open the container", 100, 100);

  si=int(size);
  displayContainer();
  blb.display(0);
  
  if(key=='q')
  {
    fill(177, 156, 217);
    noStroke();
    rect(50,50, 600,100);
    fill(255);
    text("press 'p' to squish the slime", 100, 100);
  
  //opens container top by moving up off the screen
    for(int i=0; i<10; i++)
  {
    yTop--;
    yTopT--;
   }
 }
   //change state
  if (key=='p') 
  {
    state=1;
  }

}

//now starts using values to affect the blob
void doPlay() {
  clear();
  background(177, 156, 217);
  blb.display(si);
  blb.wiggle(x, y);
  
  //change screen 
  if (blb.clearScreen()==1) {
    state=2;
  }
}

//lets user restart
void restart(){
 background(0);
    textSize(32);
    text("slime exploded! press 'r' to restart", 200, 200);
    
    //changes screen and resets blob
    if (key=='r') {
      state=0;
      blb = new BlobClass(0, 0, cChnger);
    }
}

//draws container onn the screen
void displayContainer() {
  noFill();
  stroke(255);
 
  ellipse(width/2, yTop, eWidth1, eHeight);
  ellipse(width/2, yTopT, eWidth1, eHeight);
  line(lX1, yTop, lX1, yTopT);
  line(lX2, yTop, lX2, yTopT);
  line(  lX1, yBottom, lX3, yBottomT);
  line(lX2, yBottom, lX4, yBottomT);
  ellipse(width/2, yBottomT, eWidth2, eHeight);
}
