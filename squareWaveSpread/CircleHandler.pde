class CircleHandler{
  private ArrayList<Circle> CircleList = new ArrayList<Circle>();
  private FloatList LastCircleHeights = new FloatList();
  private BasicInfo _info;
  private PVector lastCircle= new PVector(0,0);
  
  public void createCircleList(int amountOfCircles, BasicInfo info)
  {
    this._info = info;
    for(int i = 0; i < amountOfCircles; i++)
    {
      int n = i *2 +1;
      CircleList.add(new Circle(info, n));
    }
  }
  
  public void updateCircleList()
  {
    for(int i = 1; i < CircleList.size(); i++)
    {
      CircleList.get(i).setPrevious(CircleList.get(i-1));
      CircleList.get(i).setLastTotal(CircleList.get(i-1).getLastTotal());
    }
    for (Circle c : CircleList)
    {
      c.updateCircle();
    }
    lastCircle = CircleList.get(CircleList.size()-1).getLocation();
    LastCircleHeights.append(lastCircle.y);
    drawWave();
  }
  
    private void drawWave()
  {
    translate(_info.getDrawingOffset() + _info.getTranslateX(), _info.getTranslateY());
    LastCircleHeights.reverse();
    stroke(0,255,0);
    line(0, LastCircleHeights.get(0), lastCircle.x - _info.getDrawingOffset(), lastCircle.y);
    beginShape();
    for(int i = LastCircleHeights.size() -1; i > 0; i--)
    {
      vertex(i,LastCircleHeights.get(i));
    }
    endShape();
    if(LastCircleHeights.size() > width - (_info.getTranslateX() + _info.getDrawingOffset()))
    {
      LastCircleHeights.remove(LastCircleHeights.size() -1);
    }
    LastCircleHeights.reverse();
    translate((_info.getDrawingOffset() + _info.getTranslateX()) * -1, _info.getTranslateY() * -1);
  }
  
};