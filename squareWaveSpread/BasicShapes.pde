class BasicShapes{
  float squareY = 0;
  BasicInfo info;
  FloatList squareWave = new FloatList();
  public void createNewSquareWave(BasicInfo info)
  {
    this.info = info;
  }
  public void calculateSquareWave()
  {
    if(sin(info.getTime() * info.getTimeFactor()) < 0)
    {
      squareY=info.getSize();
    }
    else if (sin(info.getTime() * info.getTimeFactor()) > 0)
    {
      squareY=info.getSize() * -1;
    }
    squareWave.append(squareY);
  }
  
  public void drawSquareWave()
  {
    translate(info.getTranslateX() + info.getDrawingOffset(), info.getTranslateY());
    squareWave.reverse();
    beginShape();
    for(int i = squareWave.size() -1; i > 0; i--)
    {
      noFill();
      stroke(255,0,0);
      vertex(i, squareWave.get(i));
    }
    if(squareWave.size() > width - (info.getTranslateX() + info.getDrawingOffset()))
    {
      squareWave.remove(squareWave.size() -1 );
    }
    endShape();
    squareWave.reverse();
    translate((info.getTranslateX() + info.getDrawingOffset()) * -1, info.getTranslateY() * -1);
  }
  
  public void updateSquareWave()
  {
    calculateSquareWave();
    drawSquareWave();
  }
  
};