class BasicInfo {
  private float _time;
  private int _size;
  private int _translateX;
  private int _translateY;
  private int _radius;
  private int _diameter;
  private int _drawingOffset;
  private int _timeFactor = 1;
  private PVector baseCircle = new PVector(0,0);
  private PVector sineDot = new PVector(0,0);
  private FloatList sineWave = new FloatList();
  
  BasicInfo(float time, int size, int translateX, int translateY, int drawingOffset){
    this._time = time;
    this._size = size;
    this._translateX = translateX;
    this._translateY = translateY;
    this._drawingOffset = drawingOffset;
    init();
    drawBasics();
  }
  
  BasicInfo(int n, int size, float time, int translateX, int translateY, int drawingOffset){
    this._time = time;
    this._radius = int (size * (4 / (n * PI)));
    this._diameter = _radius * 2;
    this._translateX = translateX;
    this._translateY = translateY;
    this._drawingOffset = drawingOffset;
    this._timeFactor = n;
    drawBasics();
  }
  
  private void init()
  {
    _radius = int(_size * (4/PI));
    _diameter = _radius*2;
  }
  
  /* draws the first circle, the line from the middel to the end of the screen,
   * the straight up line next to the circle and the small dot moving around on
   * the first circle.
   * the translations there to make it less messy
  */
  private void drawBasics()
  {
    translate(_translateX, _translateY);
    baseCircle.x = 0;
    baseCircle.y = 0;
    noFill();
    stroke(255);
    ellipse(baseCircle.x, baseCircle.y, _diameter, _diameter);
    line(0,0, width - _translateX, 0);
    
    translate(_drawingOffset, 0);
      line(0,_radius, 0, _radius * -1);
    translate(_drawingOffset * -1, 0);
    
    translate(_translateX * -1, _translateY * -1);
  }
  
  /* calculates the x and y position for the dot on the first circle
   * every time this is calculated the height (y) gets saved in the 
   * FloatList to draw it later
  */
  private void calculateSine()
  {
    sineDot.x = _radius * cos(_time * _timeFactor);
    sineDot.y = _radius * sin(_time * _timeFactor) * -1;
    sineWave.append(sineDot.y);
  }
  
  /* draws the saved values of the FloatList on the line right of it
   * the line to the right represents time
   * if the wave gets begger than the screen the height values gets deleted
   * this is important to not save data we don't use
   * used beginShape and endShape to use the vertex to make the lines look better
  */
  private void drawSine()
  {
    translate(_translateX, _translateY);
    ellipse(sineDot.x, sineDot.y, 2,2);
    
    translate(_drawingOffset, 0);
      sineWave.reverse();
      line(sineDot.x - _drawingOffset, sineDot.y, 0, sineWave.get(0));
      
      beginShape();
      for(int i = sineWave.size() -1; i >= 0; i--)
      {
        noFill();
        stroke(map (_diameter, 0 , _size*2 + 100, 200, 255),  map (_diameter, 0 , _size*2 + 50, 150, 200)  , map (_diameter, 0 , _size*2 + 100, 50, 150));
        vertex(i, sineWave.get(i));
      }
      endShape();
      
      if(sineWave.size() > width - _translateX - _drawingOffset - 10)
      {
        sineWave.remove(sineWave.size()-1);
      }
      sineWave.reverse();
    translate(_drawingOffset * -1, 0);
    
    translate(_translateX * -1, _translateY * -1);
  }
  
  /* calls the calculate and draw functions in the right order 
   * usefull to keep main clean 
  */
  public void updateBasics()
  {
    drawBasics();
    calculateSine();
    drawSine();
  }
  
  /* every time main makes a loop time gets updated so to make time
   * update here as well we pass the value from main to here
   * otherways the line stays flat 
  */
  public void updateTime(float time)
  {
    this._time = time;
  }
  
  /* set the factor to multiply time with
   * used to set the frequency
  */
  public void setTimeFactor(int timeFactor)
  {
    if (timeFactor != 0)
    {
      this._timeFactor= timeFactor;
    }
  }


  /* getters to not accidently set public values that were not meant to be changed
  */
  public float getTime(){return _time;}
  public int getSize(){return _size;}
  public int getTranslateX(){return _translateX;}
  public int getTranslateY(){return _translateY;}
  public int getRadius(){return _radius;}
  public int getDiameter(){return _diameter;}
  public int getDrawingOffset(){return _drawingOffset;}
  public int getTimeFactor(){return _timeFactor;}
  public void setRadius(int radius){this._radius = radius;}
};