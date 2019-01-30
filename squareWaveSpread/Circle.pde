class Circle{
  private BasicInfo _info;
  private int _n;
  private int _radius;
  private int _diameter;
  private float _time;
  private Circle _previous;
  private PVector _lastTotal = new PVector(0,0);
  private PVector _newTotal = new PVector(0,0);
  private PVector location = new PVector(0,0);
  
  Circle(BasicInfo info, int n)
  {
    this._info = info;
    this._n = n;
  }
  
  private void calculateCircle()
  {
    _time = _info.getTime();
    _radius = int(_info.getSize() * (4/ (_n * PI)));
    _diameter = _radius*2;
    if(_n != 1)
    {
      _newTotal.x = _lastTotal.x + (_radius * cos(_n * _time * _info.getTimeFactor())); 
      _newTotal.y = _lastTotal.y + (_radius * sin(_n * _time * _info.getTimeFactor()) * -1);
    }
    else
    {
      _newTotal.x = (_radius * cos(_n * _time * _info.getTimeFactor())); 
      _newTotal.y = (_radius * sin(_n * _time * _info.getTimeFactor()) * -1);
    }
    location.x = _newTotal.x;
    location.y = _newTotal.y;
    
  }
  
  private void drawCircle()
  {
    translate(_info.getTranslateX(), _info.getTranslateY());
    noFill();
    stroke(0,255,0);
    if(_n != 1)
    {
      ellipse(_previous.getLocation().x, _previous.getLocation().y, _diameter, _diameter);
      line(_previous.getLocation().x, _previous.getLocation().y, location.x, location.y);
    }
    else
    {
      ellipse(0, 0, _diameter, _diameter);
      line(0, 0, location.x, location.y);
    }
    translate(_info.getTranslateX() * -1, _info.getTranslateY() * -1);
  }
  
  public void updateCircle()
  {
    calculateCircle();
    drawCircle();
  }
  
  public PVector getLocation(){return location;}
  public int getRadius(){return _diameter;}
  public PVector getLastTotal(){return _newTotal;}
  public void setPrevious(Circle previous){this._previous = previous;}
  public void setLastTotal(PVector lastTotal){this._lastTotal = lastTotal;}
  
};