// Final Project for NYU 2019 Creative Coding class by Markk Tong
// Title: Lost Maze
// READ BEFORE PLAY:
// Please import Minim (audio library) and gifAnimation into your processing
// If you found that gidAnimation is not compatiable in your Processing, you can drag it from file "code" into the Processing directly
// Don't mute your computer! Turn up your volume, my warriors!
// Function: W/A/S/D buttons for direction controls, and Space button for pause
// Rules: Three levels of maze are designed with increasing difficulties and challenges with each level
// When the little girl touches the wall, please be ready for being scared

// Inspirations: 
// I have been dreaming to create a game with Processing from the day 1 I took this class
// I realize that a maze game can perfectly combine shapes, mechanics, and sound together
// It will make it even more interesting if it builds on a horror theme with heart-beating maze running and jump scare after the failure

// Obstacles and challenges:
// 1. How to use library?
// 2. How to work with sound and music in Processing?
// 3. How to create walls with the testing if object touches the boundrie?
// 4. How to add difficulty and design to make it more fun to play?
// 5. HOW TO DEBUG SO MANY ERRORS IN THIS GAME!!!!!!!!!!!!!!

// Reference:
// <How to Install a Contributed Library> https://github.com/processing/processing/wiki/How-to-Install-a-Contributed-Library
// <HOW TO ADD BACKGROUND MUSIC IN PROCESSING 3.0?> https://poanchen.github.io/blog/2016/11/15/how-to-add-background-music-in-processing-3.0
// <SoundFile \ Language (API) \ Processing 3+> https://poanchen.github.io/blog/2016/11/15/how-to-add-background-music-in-processing-3.0
// <10: Intro to Images - Processing Tutorial by The Coding Train> https://www.youtube.com/watch?v=-f0WEitGmiw
// <Simple Maze game example> https://processing.org/discourse/beta/num_1263549365.html


//import two libraries
import gifAnimation.*; // for processing GIF
import ddf.minim.*; //for processing audio
Minim minim;
Minim xrminim;
AudioPlayer player;
AudioPlayer xrmp3;
PImage xr[] = new PImage[5];
PImage win;
int g3=0;
int g3st=1;
PImage bg1; 
int xri=1;
//use my own choice of font
PFont myfont;
Gif myAnimation[] = new Gif[5];
int figrun;

void setup() {
  size(1680, 1050);
  // load the victory pictures from the file "data"
  win = loadImage("win.jpg"); 
  for (int i=1; i<5; i++) { // load the ghosts faces
    xr[i] = loadImage("xr"+i+".jpg");
    xr[i].resize(1680, 1050);
  }
  
  // load the horrible fonts
  myfont=createFont("np.ttf", 100); 
  textFont(myfont);
  win.resize(1680, 1050);
  
  //load music from the file "data"
  minim = new Minim(this);
  player = minim.loadFile("bg.mp3");

  xrminim = new Minim(this);
  xrmp3 = xrminim.loadFile("xr.mp3");
  player.loop();
  
  // keep the music play over and over again
  xrmp3.loop();
  xrmp3.rewind();
  xrmp3.pause();

  // beginning image
  bg1 = loadImage("bg1.jpg");
  bg1.resize(1680, 1050);
  ellipseMode(CENTER);

  imageMode(CENTER); 
  figrun=3; // display the third fig image

  // load fig image
  for (int i=1; i<5; i++) {
    myAnimation[i] =  new Gif(this, "walk_"+i+".gif");
  }
}

// option page
int mode = 0;
int yx=41;
int yy=917;
int sd=3;
boolean run=true;

int  tun1=0;


void draw() { 

  background(0);
  //first level
  if (mode==0) { 
    xrmp3.rewind(); // BGM starts
    xrmp3.pause(); // BGM stops
    xri= int(random(1, 5)); //random ghosts faces
    run = true;
    showBackground();

    fill(255, 0, 0);
    //menu page for level1
    if (isCollisionWithRect(463, 163, 826, 114, mouseX, mouseY, 2, 2)) {
      textSize(88);
      text("first level", 763, 252);
    } else {
      textSize(77);
      text("first level", 763, 252);
    }
    
    //menu page for level2
    if (isCollisionWithRect(462, 407, 838, 121, mouseX, mouseY, 2, 2)) {
      textSize(88);
      text("second level", 763, 509);
    } else {
      textSize(77);
      text("second level", 763, 509);
    }

    //menu page for level3
    if (isCollisionWithRect(432, 640, 879, 133, mouseX, mouseY, 2, 2)) {
      textSize(88);
      text("third level", 763, 745);
    } else {
      textSize(77);
      text("third level", 763, 745);
    }
    
    // level1
  } else if (mode==1) {

    noStroke();
    fill(255);
    rect(12, 847, 1600, 158);
    rect(1447, 508, 206, 497);
    rect(65, 434, 732, 191);
    rect(65, 59, 212, 378);

    rect(275, 60, 1289, 177);
    rect(441, 508, 1026, 170);

    rect(1512, -108, 162, 342);
    fill(252, 0, 0);
    rect(1512, -4, 163, 242);

    run();
    
    //level two
  } else if (mode==2) {
     textSize(120);
    noStroke();
    fill(255);

    rect(6, 840, 1663, 134);
    rect(10, 567, 1664, 125);
    rect(11, 375, 1652, 121);
    rect(8, 197, 1656, 121);
    rect(7, 6, 1629, 122);

    rect(1510, 666, 165, 179);
    rect(34, 380, 181, 239);
    rect(1499, 230, 165, 239);
    rect(77, 65, 148, 239);
    fill(252, 252, 0);
    
    //speed up area
    text(">>>>>>>>>>>>>>>>>", 559, 474);
    text("<<<<<<<<<<<<<<<<<", 554, 671);
    fill(252, 0, 0);
    rect(1508, 6, 202, 123);
    run();
    
    //level 3
  } else if (mode==3) {
    // I designed a function to make the little girl go to random direction, but it is too hard for play, so I deleted
    //      if (key!=' '&&run) {
    //  yx +=random(-0.5, 0.5);
    //  yy +=random(-0.5, 0.5);
    //}
    textSize(120);
    //get the wall moving
    g3+=g3st;
    if (g3<0||g3>1277) {
      g3st =-g3st;
    }
    noStroke();
    fill(255);
    rect(2, 881, 1638, 83);
    rect(2652, 2263, 562, -268);
    rect(2, 612, 1639, 100);
    rect(2, 456, 1670, 100);
    rect(2, 273, 1664, 100);
    rect(3, 121, 1673, 100);
    rect(4, 5, 1512, 82);

    rect(714, 6, 128, 156);
    rect(g3, 541, 330, 168);
    rect(2688, 1181, 126, 195);

    rect(1526, 670, 114, 233);
    rect(2, 130, 119, 211);
    rect(1540, 273, 133, 239);
    fill(252, 182, 0);
    //speed up area
    text(">>>>>>>>>>>>>>>>>", 586, 541);
    text("<<<<<<<<<<<<<<<<<", 577, 701);
    text("<<<<<<<<<<<<<<<<<", 592, 366);
    fill(252, 0, 0);
    rect(1496, -13, 182, 100);
    //make it works and see if it is out of the boundries
    run();
    
    //victory after level 3 and pop up a happy face
  } else if (mode==4) {

    image(win, width/2, height/2);
  }
}



void run() {
  //keyboard control
  if (runEnd(yx, yy)==-1) {
    if (mode==1) {
      sd = 3;
    }
    if (mode==2 ) {  // test for the speed up area
      if (yx>375&&375+121<yx&&yy>304&&yy<700) {
        sd = 6;
      } else {
        sd = 3;
      }
    }
    if (mode==3) { // test for the speed up area
      if (yx>375&&375+121<yx&&yy>304&&yy<700) {
        sd = 6;
      } else {
        sd = 3;
      }
    }
    
    // test for the keyboard directions
    if (key == 'a') {
      yx-=sd;
      figrun=2;
    }
    if (key == 's') {
      yy+=sd;
      figrun=1;
    }
    if (key == 'd') {
      yx+=sd;
      figrun=3;
    }
    if (key == 'w') {
      yy-=sd;
      figrun=4;
    }
  }

  // test if it's out of the boundary
  if (runEnd(yx, yy)==-1) {
    if (xrmp3.isPlaying()) {
      xrmp3.pause(); 
      xrmp3.rewind();
    }
    fill(255, 50);
    myAnimation[figrun].play();
    image( myAnimation[figrun], yx, yy, 100, 100);
  } else if (runEnd(yx, yy)==1) {
    if (mode==3) {
      mode++;
    }
    if (mode==2) {

      mode++;
      yx=41;
      yy=917;
      key = ' ';
    }
    if (mode==1) {

      mode++;
      key = ' ';
      yx=60;
      yy=917;
    }
    ellipse(yx, yy, 50, 50);
    println(yx, yy);
  } else if (runEnd(yx, yy)==0) {

    image(xr[xri], width/2, height/2);



    if (!xrmp3.isPlaying()) {
      xrmp3.play();
    }

    run=false;

    // Again button
    if (isCollisionWithRect(984,809,374,99, mouseX, mouseY, 2, 2)) {
      textSize(130);
      text("AGAIN", 995, 890);
    } else {
      textSize(120);
      text("AGAIN", 995, 890);
    }
    
    // Menu button
       if (isCollisionWithRect(329,804,350,95, mouseX, mouseY, 2, 2)) {
      textSize(130);
      text("MENU", 330, 890);
    } else {
      textSize(120);
      text("MENU", 330, 890);
    }
  }
}


void mousePressed() {

  //click mouse one more time
  if (!run) {
    if (isCollisionWithRect(811, 798, 497, 121, mouseX, mouseY, 2, 2)) {
      key = ' ';
     // mode=0;
     figrun=3;
      yx=42;
      yy=917;
      player.rewind();
    }
    
        if (isCollisionWithRect(329,804,350,95, mouseX, mouseY, 2, 2)) {
      key = ' ';
      mode=0;
     figrun=3;
      yx=42;
      yy=917;
      player.rewind();
    }
    
  }

  if (mode==0) {
    if (isCollisionWithRect(463, 163, 826, 114, mouseX, mouseY, 2, 2)) {
      mode=1;
    }

    if (isCollisionWithRect(462, 407, 838, 121, mouseX, mouseY, 2, 2)) {
      mode=2;
    }

    if (isCollisionWithRect(432, 640, 879, 133, mouseX, mouseY, 2, 2)) {
      key=' ';
      mode=3;
    }
  }
}


//test if the little girl goes out of the boundries
int runEnd(int yx, int yy) {

  if (get(yx, yy+26)==-1&&get(yx+26, yy)==-1&&get(yx, yy-26)==-1&&get(yx-26, yy)==-1) {
    return -1;
  }

  if (get(yx, yy+26)==-16777216||get(yx+26, yy)==-16777216||get(yx, yy-26)==-16777216||get(yx-26, yy)==-16777216) {
    return 0;
  }
  if (get(yx, yy+26)==-262144||get(yx+26, yy)==-262144||get(yx, yy-26)==-262144||get(yx-26, yy)==-262144) {
    return 1;
  }
  return -1;
}

//test if the little girl touches the wall
boolean isCollisionWithRect(int x1, int y1, int w1, int h1, 
  int x2, int y2, int w2, int h2) {  
  if (x1 >= x2 && x1 >= x2 + w2) {  
    return false;
  } else if (x1 <= x2 && x1 + w1 <= x2) {  
    return false;
  } else if (y1 >= y2 && y1 >= y2 + h2) {  
    return false;
  } else if (y1 <= y2 && y1 + h1 <= y2) {  
    return false;
  }  
  return true;
}


void showBackground() {
  image(bg1, width/2, height/2);
}
