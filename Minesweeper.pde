import de.bezier.guido.*;
int MAP_SIZEX = 700;
int MAP_SIZEY = 700;
int NUM_ROWS = 20;
int NUM_COLS = 20;
int count = 0;
int change = 1;
int timer = 0;
float move = 0;
boolean firstClick = true;
color HIGHLIGHT_COLOR = color(255, 236, 33);
boolean rightClick = false;
boolean highlight = false;
boolean reset = false;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined
private ArrayList <MSButton> aroundClick;

/*
Reset map
special ability
settings???
bombs
*/
void setup ()
{
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

public void draw ()
{
    timer++;
    background( 0 );
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
}
public void keyPressed(){
      if(key == TAB){
        rightClick = !rightClick;
      }
      if(key == 'q' || key == 'Q'){
        highlight = !highlight;
      }
    if(key == 'r' || key == 'R'){
      reset = true;
    }
}
public boolean isWon()
{
    //your code here
    return false;
}
public void displayLosingMessage()
{
    //println("You lost lol");
}
public void displayWinningMessage()
{
    //your code here
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
    
    public void mousePressed () 
    {
        if(firstClick == true && mouseButton != RIGHT){
          for(int row = r-1; row < r+2; row++){
            for(int col = c-1; col < c+2; col++){
              aroundClick.add(buttons[row][col]);
            }
          }
          for(int i = 0; i < (int)((NUM_ROWS*NUM_COLS)*0.2); i++){ // Change % of bombs
            setBombs();
          }
          firstClick = false;
        }
        if(mouseButton == RIGHT || rightClick == true){
          marked = !marked;
          if(marked == false){
            clicked = false;
          }
          // Fail safe
        }else{ // Fixes bug of clicking 2 squares at once - makes sure there is > 1000 frames between clicks
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

    public void draw () 
    {    
        
        count++;
        if( clicked && bombs.contains(this) ) {
             fill(255,0,0);
             for(int r = 0; r < buttons.length; r++){
               for(int c = 0; c < buttons[0].length; c++){
                 if(bombs.contains(buttons[r][c])){
                   buttons[r][c].setClicked();
                 }
               }
             }
             displayLosingMessage();
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
          rect(x+1,y + height - height/14, width, height/10);
        }
        }
        stroke(0);
        fill(0);
        if(marked){
          fill(255,0,0);
          ellipse(x+width/2,(y+height/2 - 5) + move,width/6, width/2);
          ellipse(x+width/2,(y+height/2 + 10) + move,width/6, width/6);
        }else{
          text(label,x+width/2,y+height/2);
        }
        
    }
    public void move(){
//      timer++;
      
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
