

import de.bezier.guido.*;
int MAP_SIZEX = 700;
int MAP_SIZEY = 700;
int NUM_ROWS = 20;
int NUM_COLS = 20;
int count = 0;
private MSButton[][] buttons; //2d array of minesweeper buttons
private ArrayList <MSButton> bombs; //ArrayList of just the minesweeper buttons that are mined

void setup ()
{
    size(750, 700); // I have a map size variable too, so this "screen size" has to be constant
    textAlign(CENTER,CENTER);
    // make the manager
    Interactive.make( this );
    buttons = new MSButton[NUM_ROWS][NUM_COLS];
    bombs = new ArrayList <MSButton>();
    for(int r = 0; r < NUM_ROWS; r++){
      for(int c = 0; c < NUM_COLS; c++){
        buttons[r][c] = new MSButton(r,c);
      }
    }
    for(int i = 0; i < (int)((NUM_ROWS*NUM_COLS)*0.2); i++){ // Change % of bombs
      setBombs();
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
  while(bombs.contains(buttons[rRow][rCol])){
    rRow = (int)(Math.random()*NUM_ROWS);
    rCol = (int)(Math.random()*NUM_COLS);
  }
  if(!bombs.contains(buttons[rRow][rCol])){ // Just insurance!
    bombs.add(buttons[rRow][rCol]);
  }
  //
  //////////////////////////////////////////
}

public void draw ()
{
    background( 0 );
    if(isWon())
        displayWinningMessage();
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
    
    public MSButton ( int rr, int cc )
    {
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
    // called by manager
    
    public void mousePressed () 
    {
        if(mouseButton == RIGHT){
          marked = !marked;
          if(marked == false){
            clicked = false;
          }
          // Fail safe
        }else{ // Fixes bug of clicking 2 squares at once - makes sure there is > 1000 frames between clicks
          clicked = true;
          count = 0;
          if(countBombs(r, c) > 0){
            setLabel("" + countBombs(r, c));
          }else{ // count > 1000
            for(int rI = r - 1; rI < r + 2; rI++){
              for(int cI = c - 1; cI < c + 2; cI++){
                if(isValid(rI,cI) == true && buttons[rI][cI].isClicked() == false){
                  buttons[rI][cI].mousePressed();
                  //buttons[rI][cI].setClicked();
                }
              }
            }
          }
        }
    }

    public void draw () 
    {    
        count++;
        if (marked){
            fill(0);
        }else if( clicked && bombs.contains(this) ) {
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
        rect(x, y, width, height);
        fill(0);
        text(label,x+width/2,y+height/2);
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
