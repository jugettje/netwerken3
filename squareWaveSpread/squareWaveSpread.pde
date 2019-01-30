int circleNumbers = 7;

BasicInfo info[] = new BasicInfo[circleNumbers];
BasicInfo infoXTRA[] = new BasicInfo[circleNumbers];
BasicShapes square = new BasicShapes();
BasicShapes square2 = new BasicShapes();
CircleHandler h = new CircleHandler();
float time = 0;
int distances[] = new int[]{500, 590 , 630, 657, 680, 700, 715};

void setup()
{
  size(1600,800);
  info[0] = new BasicInfo(time, 50, 150, 200 , 150);
  info[1] = new BasicInfo(time, 50, 150, 350 , 150);
  
  for(int i = 2; i < circleNumbers; i++)
  {
    int n = i *2 -1;
    info[i] = new BasicInfo(n, 50, time, 150, 350  /* + (i - 1)*50 */ , 150);
  }
  
  for(int i = 0; i < circleNumbers; i++)
  {
    int n = i *2 +1;
    infoXTRA[i] = new BasicInfo(n, 50, time, 150, distances[i] , 150);
  }

  
  square.createNewSquareWave(info[0]);
  //square2.createNewSquareWave(info[3]);
  
  h.createCircleList(circleNumbers -1 , info[0]);
}

void draw()
{
  background(0);
  
  for (BasicInfo i : info)
  {
    i.updateBasics();
  }
  for (BasicInfo i : infoXTRA)
  {
    i.updateBasics();
  }
  
  //square2.updateSquareWave();
  square.updateSquareWave();
  h.updateCircleList();
  
  
  time += 0.01;
  
  
  for (BasicInfo i : info)
  {
    i.updateTime(time);
  }
  for (BasicInfo i : infoXTRA)
  {
    i.updateTime(time);
  }
}