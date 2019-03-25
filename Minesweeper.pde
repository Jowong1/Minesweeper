
import de.bezier.guido.*;
int MAP_SIZEX = 700;
int MAP_SIZEY = 700;
int NUM_ROWS = 20;
int NUM_COLS = 20;
int count = 0;
int change = 1;
int timer = 0;
int brightness = 0; //0 bright, 255 dark
int shiftX = 55;
int shiftY = 80;
int drag = 0;
int setX = 28 + 430 - 55 + shiftX;
int countToTen = 0;
int transparency = 255;
float move = 0;
float spin = 0;
boolean firstClick = true;
color HIGHLIGHT_COLOR = color(255, 236, 33);
boolean rightClick = false;
boolean highlight = false;
boolean resetThis = false;
boolean gameOver = false;
boolean restartGame = false;
boolean canReset = false;
boolean displayLose = true;
boolean displaySettingsBoolean = false;
boolean displayInfoBoolean = false;
boolean canPlay = true;
boolean pressingClose = false;
boolean bOne = false;
boolean bTwo = false;
boolean bEasy = false;
boolean bMedium = true;
boolean bHard = false;
boolean bArrow = false;
boolean bPickaxe = false;
boolean bCross = true;
boolean isDrag = false;
boolean countTenB = false;
boolean released = false;
boolean comingSoon = false;
float percentBombs = 0.2;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private ArrayList <MSButton> aroundClick;

/*
homescreen?? MINESWEEPER(THEN BOMB) click each box
Reset map
special ability
settings???
win message
lose message

>TAB BAR<
-Xreset
-Vhighlight on/off
-Vflag mode on/off
--special ability
-instructions
*/

void setup ()
{
    background(0);
    size(750, 700); // I have a map size variable too, so this "screen size" has to be constant
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    aroundClick = new ArrayList <MSButton>();
    bombs = new ArrayList <MSButton>();
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
}
///THIS
//public void mousePressed(){
//  if(gameOver == true){
//    //width/2 - 25, height/2 + 27.5, 150, 30
//    if(mouseX > width/2 - 25 - 75 && mouseX < width/2 - 25 + 75 && mouseY > height/2 + 27.5 - 15 && mouseY < height/2 + 27.5 + 15){
//      restartThis();
//      gameOver = false;
//      restartGame = false;
//      firstClick = true;
//      rightClick = false;
//    }
//  }
//}

public void keyPressed(){
    if(key == 'q' || key == 'Q'){
      rightClick = !rightClick;
    }
    if(key == 't' || key == 'T'){
      highlight = !highlight;
    }
    if(key == 'r' || key == 'R'){
    resetThis = true;
    }
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
  rectMode(CENTER);
  fill(255);
  rect(width/2 - 25, height/2, 300, 100);
  rect(width/2 - 25, height/2 + 27.5, 150, 30);
  fill(0, brightness);
  rect(width/2 - 25, height/2, 300, 100);
  fill(0);
  textSize(50);
  text("Oh no!", width/2 - 25, height/2 - 20);
  textSize(20);

  text("Retry?", width/2 - 25, height/2 + 25);
  textSize(12);
  rectMode(CORNER);
}
public void displayWinningMessage()
{
    rectMode(CENTER);
    fill(255);
    rect(width/2 - 25, height/2, 300, 100);
    rect(width/2 - 25, height/2 + 27.5, 150, 30);
    fill(0, brightness);
    rect(width/2 - 25, height/2, 300, 100);
    fill(0);
    textSize(50);
    text("You Win!", width/2 - 25, height/2 - 20);
    textSize(20);
  
    text("Again?", width/2 - 25, height/2 + 25);
    textSize(12);
    rectMode(CORNER);
}
public void displaySettingsButton()
{
    //SETTINGS BUTTON
    fill(255);
    rectMode(CENTER);
    rect(width - 25, 25, 50, 50);
    fill(0);
    rect(width - 25, 25, 42, 42);
    rectMode(CORNER);
    fill(255);
    ellipse(width - 25, 25, 20, 20);
    fill(0);
    ellipse(width - 25, 25, 10, 10);
    pushMatrix();
    noStroke();
    translate(width - 25, 25);
    rectMode(CENTER);
    fill(255);
    rotate(spin);
    for(int i = 0; i < 6; i++){
      rect(0, -10, 6, 6);
      rotate(PI/3);
    }
    //rect(0, -10, 6, 6);
    //rotate(PI/3);
    //rect(0, -10, 6, 6);
    //rotate(PI/3);
    //rect(0, -10, 6, 6);
    //rotate(PI/3);
    //rect(0, -10, 6, 6);
    //rotate(PI/3);
    //rect(0, -10, 6, 6);
    //rotate(PI/3);
    //rect(0, -10, 6, 6);
    spin = spin + 0.0001;
    rectMode(CORNER);
    stroke(0);
    popMatrix();
}

public void displaySettings()
{   
    //SETTINGS
    fill(0);
    rectMode(CENTER);
    rect(width/2 - 25, height/2, 400, 500);
    rectMode(CORNER);
    fill(255);
    textSize(30);
    text("Settings", width/2 - 25, 140);
    textSize(12);
    settingsButtons();
    if(comingSoon == true){
      comingSoonText();
    }
    if(displaySettingsBoolean == true){
      highlight = false;
    }
}
public void closeButton(){
  rectMode(CENTER);
  if(countToTen > 0 && released == true){
    fill(150);
    rect(width/2 + 150, height/2 - 225, 23, 23);
  }else if(pressingClose == true){
    fill(150);
    rect(width/2 + 150, height/2 - 225, 23, 23);
  }else{
    fill(255);
    rect(width/2 + 150, height/2 - 225, 30, 30);
  }
  fill(0);
  line(width/2 + 150 - 15, height/2 - 225 - 15, width/2 + 150 + 15, height/2 - 225 + 15);
  line(width/2 + 150 - 15, height/2 - 225 + 15, width/2 + 150 + 15, height/2 - 225 - 15);
  rectMode(CORNER);
}
public void settingsButtons(){
  /*
  -brightness
  -cursor(cross,normal,pickaxe)
  -close settings
  -powerups
  -difficulty
  -instructions
  */
  //CLOSE SETTINGS
  closeButton();
  /*
  for(int r = 0; r < 181; r+=60){ // 181
    for(int c = 0; c < 181; c+=180){ // 181
      fill(255);
      rect(width/2 - 190 + c, 180 + r, 20, 20);
      fill(0);
      rect(width/2 - 187 + c, 183 + r, 14, 14);
    }
  }
  //BUTTON (ON) DISPLAY
  
  if(bOne == true){
    fill(255);
    rect(width/2 - 186, 184, 12, 12);
  }
  if(bTwo == true){
    fill(255);
    rect(width/2 - 186 + 180, 184, 12, 12);
  }
  */
  // DIFFICULTY
  for(int r = shiftY; r < 101 + shiftY; r+=100){ // 181
    for(int c = shiftX; c < 201 + shiftX; c+=100){ // 181
      fill(255);
      rect(width/2 - 190 + c, 180 + r, 20, 20);
      fill(0);
      rect(width/2 - 187 + c, 183 + r, 14, 14);
    }
  }
  if(bEasy == true){
    fill(255);
    rect(width/2 - 186 + shiftX, 184 + shiftY, 12, 12);
  }
  if(bMedium == true){
    fill(255);
    rect(width/2 - 186 + 100 + shiftX, 184 + shiftY, 12, 12);
  }
  if(bHard == true){
    fill(255);
    rect(width/2 - 186 + 200 + shiftX, 184 + shiftY, 12, 12);
  }
  if(bArrow == true){
    fill(255);
    rect(width/2 - 186 + shiftX, 184 + 100 + shiftY, 12, 12);
    comingSoon = false; // 
  }
  if(bPickaxe == true){
    fill(255);
    rect(width/2 - 186 + 100 + shiftX, 184 + 100 + shiftY, 12, 12);
    comingSoon = true; // 
  }
  if(bCross == true){
    fill(255);
    rect(width/2 - 186 + 200 + shiftX, 184 + 100 + shiftY, 12, 12);
    comingSoon = false; // 
  }
  rectMode(CENTER);
  rect(width/2 - 80 + shiftX, 400 + shiftY - 35, 230, 14);
  fill(0);
  rect(width/2 - 80 + shiftX, 400 + shiftY - 35, 224, 8);
  //Brightness scroller
  noStroke();
  fill(255);
  if(isDrag == true){
    if(mouseX <= 458 - 55 + shiftX && mouseX >= 243 - 55 + shiftX){
      setX = mouseX;
    }else if(mouseX > 458 - 55 + shiftX){
      setX = 458 - 55 + shiftX;
    }else if(mouseX < 243 - 55 + shiftX){
      setX = 243 - 55 + shiftX;
    }
    brightness = 458 - setX - 40;
    /*
     ^^^width/2 - 80 + shiftX is MIDDLE
        width/2 + 28 + shiftX or + 30 is MAX/RIGHT
        width/2 - 188 +  shiftX LOW/LEFT
        range is from +28 to -188 |OR| 216
    */
  }else{

  }
  rect(setX, 400 + shiftY - 35, 10, 20);
  stroke(0);
  rectMode(CORNER);
  fill(255);
  textSize(25);
  text("Difficulty", width/2 - 80 + shiftX, 134 + shiftY);
  text("Cursor", width/2 - 80 + shiftX, 234 + shiftY);
  text("Brightness", width/2 - 80 + shiftX, 367 - 35 + shiftY);
  textSize(18);
  text("Easy", width/2 - 180 + shiftX, 164 + shiftY);
  text("Medium", width/2 - 80 + shiftX, 164 + shiftY);
  text("Hard", width/2 + 20 + shiftX, 164 + shiftY);
  text("Arrow", width/2 - 180 + shiftX, 264 + shiftY);
  text("Pickaxe", width/2 - 80 + shiftX, 264 + shiftY);
  text("Cross", width/2 + 20 + shiftX, 264 + shiftY);
  textSize(12);
}
public void displayInfoButton(){
  stroke(255);
  fill(255);
  rectMode(CENTER);
  rect(width - 25, 70, 48, 48);
  fill(0);
  stroke(0);
  rect(width - 25, 70, 42, 42);
  
  fill(255);
  noStroke();
  ellipse(width - 24.5, 70, 35.5, 35.5);
  fill(0);
  ellipse(width - 24.5, 70, 29.5, 29.5);
  fill(255);
  ellipse(width - 24.5, 61, 6, 6);
  stroke(255);
  rect(width - 25.5, 74, 3.5, 8); //
  ellipse(width - 24.5, 69, 3.5, 3.5);
  ellipse(width - 24.5, 79.5, 3.5, 3.5);
  stroke(0);
  rectMode(CORNER);
}
public void displayInfo()
{   
    //INFO
    fill(0);
    rectMode(CENTER);
    rect(width/2 - 25, height/2, 400, 500);
    rectMode(CORNER);
    fill(255);
    textSize(30);
    text("Instructions", width/2 - 25, 140);
    textSize(18);
    text("The goal of the game is to uncover all\ntiles without hitting any bombs", width/2 - 80 + shiftX, 130 + shiftY);
    textSize(16);
    text("Right click or toggle with 'Q' to flag a tile", width/2 - 80 + shiftX, 140 + 60 + shiftY);
    text("'T' for Assist Mode", width/2 - 80 + shiftX, 140 + 95 + shiftY);
    text("'R' to reset", width/2 - 80 + shiftX, 130 + 140 + shiftY);
    textSize(12);
    closeButton();
    if(displayInfoBoolean == true){
      highlight = false;
    }
}
public void comingSoonText(){
  textSize(18);
  fill(255);//, transparency);
  text("Coming Soon!", width/2 - 186 + 100 + 5 + shiftX, 184 + 100 + 25 + shiftY);
  textSize(12);
  /*
  if(transparency > 0){
    transparency-=0.00001;
    println(transparency);
  }else{
    transparency = 255;
    comingSoon = false;
  }
  */
}
public void screenBrightness(){
  fill(0, brightness);
  rectMode(CORNER);
  rect(width - 50, 0, 50 + 2, height - 100);
  if(displaySettingsBoolean == true){
    rectMode(CENTER);
    rect(width/2 - 25, height/2, 400, 500);
    rectMode(CORNER);
  }
}
public class MSButton
{
    private int r, c;
    private float x,y, width, height;
    private boolean clicked, marked;
    private String label;
//    private int timer;
    
    public MSButton ( int rr, int cc )
    {
        timer = 0;
        width = MAP_SIZEX/NUM_COLS;
        height = MAP_SIZEY/NUM_ROWS;
        r = rr;
        c = cc; 
        x = c*width;
        y = r*height;
        label = "";
        marked = clicked = false;
        Interactive.add( this ); // register it with the manager
    }
    public boolean isMarked()
    {
        return marked;
    }
    public boolean isClicked()
    {
        return clicked;
    }
    public boolean setClicked() // My own: sets the input button as 'clicked'
    {
        clicked = true;
        return clicked;
    }
    public void setBombs()
    {
      // For a random number of bombs on the map
      /*
      int rRow = (int)(Math.random()*NUM_ROWS);
      int rCol = (int)(Math.random()*NUM_COLS);
      if(!bombs.contains(buttons[rRow][rCol])){
        bombs.add(buttons[rRow][rCol]);
      }
      */
      //////////////////////////////////////////
      // For a set number of bombs on the map
      //
      int rRow = (int)(Math.random()*NUM_ROWS);
      int rCol = (int)(Math.random()*NUM_COLS);
      while(bombs.contains(buttons[rRow][rCol]) == true || aroundClick.contains(buttons[rRow][rCol]) == true){
        rRow = (int)(Math.random()*NUM_ROWS);
        rCol = (int)(Math.random()*NUM_COLS);
      }
      bombs.add(buttons[rRow][rCol]);
      //
      //////////////////////////////////////////
    }
    public boolean noneClicked(){
      int clickedNum = 0;
      for(int r = 0; r < buttons.length; r++){
        for(int c = 0; c < buttons[0].length; c++){
          if(buttons[r][c].isClicked()){
            clickedNum++;
          }
        }
      }
      if(clickedNum == 0){
        return true;
      }else{
        return false;
      }
    }
    public boolean allClicked(){
      int notClicked = 0;
      for(int r = 0; r < buttons.length; r++){
        for(int c = 0; c < buttons[0].length; c++){
          if(buttons[r][c].isClicked() || bombs.contains(buttons[r][c])){
          }else{
            notClicked++;
          }
        }
      }
      if(notClicked == 0){
        return true;
      }else{
        return false;
      }
    }
    public void mousePressed () 
    {
      if(canPlay == true){
        if(gameOver == false){
          if(firstClick == true && mouseButton == LEFT){
            for(int row = r-1; row < r+2; row++){
              for(int col = c-1; col < c+2; col++){
                aroundClick.add(buttons[row][col]);
              }
            }
            for(int i = 0; i < (int)((NUM_ROWS*NUM_COLS)*percentBombs); i++){ // Change % of bombs (int)((NUM_ROWS*NUM_COLS)*0.2)
              setBombs();
            }
            firstClick = false;
          }
          if((mouseButton == RIGHT || rightClick == true) && clicked == false){
            marked = !marked;
            if(marked == false){
              clicked = false;
            }
            // Fail safe
          }else if(bombs.contains(this) && firstClick == false){
               for(int r = 0; r < buttons.length; r++){
                 for(int c = 0; c < buttons[0].length; c++){
                   if(bombs.contains(buttons[r][c])){
                     buttons[r][c].setClicked();
                   }
                 }
               }
               gameOver = true;
          }else if(displayLose == false){ // Fixes bug of clicking 2 squares at once - makes sure there is > 1000 frames between clicks
            clicked = true;
            count = 0;
            if(isValid(r,c) == true && countBombs(r, c) > 0 && bombs.contains(this) == false){
              setLabel("" + countBombs(r, c));
            }else{ // count > 1000
              for(int rI = r - 1; rI < r + 2; rI++){
                for(int cI = c - 1; cI < c + 2; cI++){
                  if(isValid(rI,cI) == true && bombs.contains(this) == false && buttons[rI][cI].isClicked() == false){
                    buttons[rI][cI].mousePressed();
                  }
                }
              }
            }
          }
        }
      }
    }

    public void draw () 
    {    
        count++;
        displaySettingsButton();
        displayInfoButton();
        if(allClicked() == true){
          displayWinningMessage();
          gameOver = true;
        }
        if(gameOver == true && clicked && bombs.contains(this) ) {
             fill(255,0,0);
        }else if(clicked){
            fill( 200 );
        }else{
            fill( 100 );
        }
        if(marked){
          fill(0);
        }
        if(mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height){
          //fill(255, 255, 255, 50);
          //fill(255, 245, 142);
          rectMode(CENTER);
          //rect(x, y, 300,300);
          rectMode(CORNER);
        }
        /*
        //HIGHLIGHT MODE
        if(!marked && mouseX > x - width && mouseX < x + width + width && mouseY > y - height && mouseY < y + height + height){
          fill(255, 255, 255, 50);
          //rect(x + width/4, y + height/4, height/2, width/2);
        }
        */
        rect(x, y, width, height);
        fill(0, brightness);
        rect(x, y, width, height);
        if(gameOver == true && clicked && bombs.contains(this) && marked == false){
             //for(int i = 0; i < width; i+=10){
             //  ellipse(x + i, y, 10,10);
             //}
             fill(10);
             ellipse(x + width/2, y + height/1.7, width/1.7, height/1.7);
             //fill(0);
             //ellipse(x + width/1.7, y + height/1.7, 8, 8);
             noFill();
             stroke(255);
             beginShape();
             curveVertex(x + 22, y + 1);//
             curveVertex(x + 27, y + 7);
             curveVertex(x + 22, y + 11);
             curveVertex(x + 21, y + 12);
             curveVertex(x + 20, y + 14);
             curveVertex(x + 18, y + 18);//
             endShape();
             stroke(0, brightness);
             beginShape();
             curveVertex(x + 22, y + 1);//
             curveVertex(x + 27, y + 7);
             curveVertex(x + 22, y + 11);
             curveVertex(x + 21, y + 12);
             curveVertex(x + 20, y + 14);
             curveVertex(x + 18, y + 18);//
             endShape();
        }
        if(highlight){
          fill(HIGHLIGHT_COLOR);
          noStroke();
          if(mouseX > x + width && mouseX < x + width*2 && mouseY > y - height && mouseY < y + height*2 ){
            rect(x+1,y+1, width/14, height);
          }
          if(mouseX < x && mouseX > x - width && mouseY > y - height && mouseY < y + height*2 ){
            rect(x + width - (width/14) - 1,y+1, width/10, height);
          }
          if(mouseY > y + height && mouseY < y + height*2 && mouseX > x - width && mouseX < x + width*2 ){
            rect(x+1,y+1, width, height/14);
          }
          if(mouseY < y && mouseY > y - height && mouseX > x - width && mouseX < x + width*2 ){
            rect(x+1,y + height - (height/14) - 1, width, height/10);
          }
          fill(0, brightness);
          if(mouseX > x + width && mouseX < x + width*2 && mouseY > y - height && mouseY < y + height*2 ){
            rect(x+1,y+1, width/14, height);
          }
          if(mouseX < x && mouseX > x - width && mouseY > y - height && mouseY < y + height*2 ){
            rect(x + width - (width/14) - 1,y+1, width/10, height);
          }
          if(mouseY > y + height && mouseY < y + height*2 && mouseX > x - width && mouseX < x + width*2 ){
            rect(x+1,y+1, width, height/14);
          }
          if(mouseY < y && mouseY > y - height && mouseX > x - width && mouseX < x + width*2 ){
            rect(x+1,y + height - (height/14) - 1, width, height/10);
          }
        }
        stroke(0);
        fill(0);
        if(marked){
          fill(255,0,0);
          ellipse(x+width/2,(y+height/2 - 5) + move,width/6, width/2);
          ellipse(x+width/2,(y+height/2 + 10) + move,width/6, width/6);
        }else{
          if(canPlay == true && mouseX > x && mouseX < x + width && mouseY > y && mouseY < y + height){
            text(label,x+width/2,(y+height/2) - 4);
          }else{
            text(label,x+width/2,y+height/2);
          }
        }
        if(gameOver == true && bombs.contains(this) == false && marked == true){
          stroke(255,0,0);
          strokeWeight(2);
          line(x + 2, y + 2, x + width - 2, y + height - 2);
          line(x + width - 2, y + 2, x + 2, y + height - 2);
          strokeWeight(1);
          stroke(0);
        }
        if(gameOver == true && allClicked() == false){
          displayLosingMessage();
          displayLose = true;
        }else if(gameOver == true && allClicked() == true){
          displayLose = false;
          displayWinningMessage();
        }else{
          displayLose = false;
        }
        if(displaySettingsBoolean == true){
          displaySettings();
        }
        if(displayInfoBoolean == true){
          displayInfo();
        }
        screenBrightness();
    }
    public void setLabel(String newLabel)
    {
        label = newLabel;
    }
    public boolean isValid(int r, int c)
    {
      if(r >= 0 && r <= NUM_ROWS - 1 && c >= 0 && c <= NUM_COLS - 1){
        return true;
      }else{
        return false;
      }
    }
    public int countBombs(int row, int col)
    {
      int numBombs = 0;
      for(int r = row - 1; r < row + 2; r++){
        for(int c = col - 1; c < col + 2; c++){
          if(isValid(r,c) == true && bombs.contains(buttons[r][c])){
            numBombs++;
          }
        }
      }
      if(bombs.contains(buttons[row][col])){ // Just a little bit of insurance
        numBombs--;
      }
      return numBombs;
    }
}
public void draw ()
{
  if(countTenB == true){
    countToTen++;
  }
  if(released == true && countToTen >= 2){
    countToTen = 0;
    countTenB = false;
    displaySettingsBoolean = false;
    displayInfoBoolean = false;
    released = false;
    canPlay = true;
  }
  if(bCross == true){
    cursor(CROSS);
  }else if(bPickaxe == true){
    //cursor(img);
  }else if(bArrow == true){
    cursor(ARROW);
  }
  if(canPlay == true){
    if(resetThis == true){
      restartThis();
      resetThis = false;
      gameOver = false;
      restartGame = false;
      rightClick = false;
      firstClick = true;
    }
    timer++;
    if(isWon()){
        displayWinningMessage();
    }
    if(timer < 130){
        move = 0;
      }else if(timer >= 130 && timer < 135){
        move = move - 2;
      }else if(timer >= 135 && timer < 140){
        move = move + 2;
      }else if(timer >= 140){
        timer = 0;
      }
   
   //FLAG MODE
   if(rightClick == true){
     fill(255);
     rect(width - 50, height - 50, 50, 50);
     fill(0);
     text("FLAG\nMODE", width - 25, height - 25);
     fill(0, brightness);
     rect(width - 50, height - 50, 50, 50);
   }else{
     fill(0);
     rect(width - 50, height - 50, 50, 50);
   }
   //HIGHLIGHT MODE
   if(highlight == true){
     fill(255);
     rect(width - 50, height - 100, 50, 50);
     fill(0);
     text("ASSIST\nMODE", width - 25, height - 75);
     fill(0, brightness);
     rect(width - 50, height - 100, 50, 50);
   }else{
     fill(0);
     rect(width - 50, height - 100, 50, 50);
   }
  }
}
public void mousePressed(){
  //SETTINGS
  if(mouseX > width - 50 && mouseX <  width && mouseY > 0 && mouseY < 47.5){
    displaySettingsBoolean = true;
    canPlay = false;
    displayInfoBoolean = false;
  }
  if(mouseX > width - 50 && mouseX <  width && mouseY > 47.5 && mouseY < 100){
    displayInfoBoolean = true;
    canPlay = false;
    displaySettingsBoolean = false;
  }
  if(displaySettingsBoolean == true){
    if(mouseX > width/2 + 150 - 15 && mouseY > height/2 - 225 - 15 && mouseX < width/2 + 150 + 15 && mouseY < height/2 - 225 + 15){
      pressingClose = true;
      countTenB = true;
    }
    // bOne on/off
    if(mouseX > (width/2 - 190) && mouseY > (180) && mouseX < (width/2 - 170) && mouseY < (200)){
      bOne = !bOne;
    }
    // bTwo on/off
    if(mouseX > (width/2 - 190 + 180) && mouseY > (180) && mouseX < (width/2 - 170 + 180) && mouseY < (200)){
      bTwo = !bTwo;
    }
    //Difficulty
      //Easy
    if(mouseX > (width/2 - 190 + shiftX) && mouseY > (180 + shiftY) && mouseX < (width/2 - 190 + 20 + shiftX) && mouseY < (180 + 20 + shiftY)){
      percentBombs = 0.1;
      bEasy = true;
      bMedium = false;
      bHard = false;
      resetThis = true;
    }
      //Medium
    if(mouseX > (width/2 - 190 + 100 + shiftX) && mouseY > (180 + shiftY) && mouseX < (width/2 - 190 + 20 + 100 + shiftX) && mouseY < (180 + 20 + shiftY)){
      percentBombs = 0.2;
      bEasy = false;
      bMedium = true;
      bHard = false;
      resetThis = true;
    }
      //Hard
    if(mouseX > (width/2 - 190 + 200 + shiftX) && mouseY > (180 + shiftY) && mouseX < (width/2 - 190 + 20 + 200 + shiftX) && mouseY < (180 + 20 + shiftY)){
      percentBombs = 0.3;
      bEasy = false;
      bMedium = false;
      bHard = true;
      resetThis = true;
    }
    
    //Cursor
      //Arrow
    if(mouseX > (width/2 - 190 + shiftX) && mouseY > (280 + shiftY) && mouseX < (width/2 - 190 + 20 + shiftX) && mouseY < (280 + 20 + shiftY)){
      bArrow = true;
      bPickaxe = false;
      bCross = false;
    }
      //Pickaxe
    if(mouseX > (width/2 - 190 + 100 + shiftX) && mouseY > (280 + shiftY) && mouseX < (width/2 - 190 + 20 + 100 + shiftX) && mouseY < (280 + 20 + shiftY)){
      bArrow = false;
      bPickaxe = true;
      bCross = false;
      //comingSoon = true;
    }
      //Cross
    if(mouseX > (width/2 - 190 + 200 + shiftX) && mouseY > (280 + shiftY) && mouseX < (width/2 - 190 + 20 + 200 + shiftX) && mouseY < (280 + 20 + shiftY)){
      bArrow = false;
      bPickaxe = false;
      bCross = true;
    }
  }
  if(displayInfoBoolean == true){
    if(mouseX > width/2 + 150 - 15 && mouseY > height/2 - 225 - 15 && mouseX < width/2 + 150 + 15 && mouseY < height/2 - 225 + 15){
      pressingClose = true;
      countTenB = true;
    }
  }
  rect(width/2 - 25, height/2, 400, 500);
  if(gameOver == true){// && canReset == true){
    //width/2 - 25, height/2 + 27.5, 150, 30
    if(canReset == true && mouseX > width/2 - 25 - 75 && mouseX < width/2 - 25 + 75 && mouseY > height/2 + 27.5 - 15 && mouseY < height/2 + 27.5 + 15){
      restartThis();
      gameOver = false;
      restartGame = false;
      firstClick = true;
      canReset = false;
    }else if(mouseX > width/2 - 25 - 75 && mouseX < width/2 - 25 + 75 && mouseY > height/2 + 27.5 - 15 && mouseY < height/2 + 27.5 + 15){
      canReset = true;
    }
  }
}
public void mouseReleased(){
  if(pressingClose == true){
    pressingClose = false;
    released = true;
  }
  if(isDrag == true){
    isDrag = false;
  }
}
public void mouseDragged(){
  //Brightnessp
    //rect(setX + shiftX, 400 + shiftY, 10, 20); 
    if(mouseX > setX - 6 && mouseY > 400 + shiftY - 11 - 35 && mouseX < setX + 6 & mouseY < 400 + shiftY + 11 - 35){
      isDrag = true;
    }
    // 243, 459
}
public void restartThis(){
      for(int r = 0; r < buttons.length; r++){
        for(int c = 0; c < buttons[0].length; c++){
          if(buttons[r][c].isMarked() == true){
            buttons[r][c].marked = false;
          }
          if(buttons[r][c].isClicked() == true){
            buttons[r][c].clicked = false;
          }
          if(buttons[r][c].label != ""){
            buttons[r][c].label = "";
          }
        }
      }
      // WHY IS THIS AN ERROR?? THE COMMENTED 'FOR LOOPS' DON'T REMOVE EVERYTHING IN THE ARRAYLIST!!!
      //for(int i = 0; i < bombs.size(); i++){
      //  bombs.remove(i);
      //}
      //for(int i = 0; i < aroundClick.size(); i++){
      //  aroundClick.remove(i);
      //}
      bombs.clear();
      aroundClick.clear();
}
