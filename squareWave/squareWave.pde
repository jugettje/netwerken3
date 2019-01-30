import java.util.Collections;

float time = 0;
FloatList wave = new FloatList();
FloatList sinWave = new FloatList();
FloatList squareWave = new FloatList();
ArrayList<PVector> circle2d = new ArrayList<PVector>();
int lastNtimes = 0;

void setup()
{
 size(1600,450); 
}

void draw()
{
  background(0);
  translate (300, 250);
  float x = 0, sinX = 100 * (4/PI) * cos(time);
  float y = 0, sinY = 100 * (4/PI) * sin(time)* -1;
  float sqY = 0;
  ellipse (sinX, sinY, 2,  2 );
  sinWave.append(sinY);
  
  if (sin(time) < 0)
  {
    sqY = 100;
  }
  else if (sin(time) > 0)
  {
    sqY = -100;
  }
  squareWave.append(sqY);
  int Ntimes = int(map(mouseY, 9, height, 2, 50));
  
  if (lastNtimes > Ntimes || lastNtimes < Ntimes)
  {
    circle2d.clear();
  }
  
  for(int i = 0; i< Ntimes; i++)
  {
    float prevX = x;
    float prevY = y;
    
    int n = i * 2 + 1;
    float radius = 100 * (4/ (n * PI));
    stroke(100, 100);
    noFill();
    ellipse (prevX, prevY, radius*2, radius*2);
    x += radius * cos(n * time);
    y += -1 * radius * sin(n * time);
    
    
    
    fill(255);
    stroke(255);
    ellipse(x,y,2,2);
    line(prevX,prevY,x,y);
    stroke(255,0,0);
  
    line(0, 0, 1200, 0);
    line(1200,radius, 1200, radius*-1);
    stroke(0,255,0);
    line(300,radius, 300, radius*-1);
  }
  circle2d.add(new PVector(x,y));
  wave.append(y);
  
  Collections.reverse(circle2d);
  beginShape();
    for(int i = circle2d.size() -1; i > 0; i--)
    {
      noFill();
      stroke(255);
      vertex(circle2d.get(i).x, circle2d.get(i).y);
    }
  endShape();
  if(circle2d.size() > 600)
  {
    circle2d.remove(circle2d.size()-1);
  }
  Collections.reverse(circle2d);
  
  
    squareWave.reverse();
  beginShape();
  for(int i = squareWave.size() -1; i > 0; i--)
  {
    noFill();
    stroke(0,255,0);
    vertex(i+300, squareWave.get(i));
  }
  endShape();
  if(squareWave.size() > 900)
  {
    squareWave.remove(squareWave.size()-1);
  }
  squareWave.reverse();
  
  //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ REVERSE
  wave.reverse();
  stroke(255,0,0);
  strokeWeight(2);
  line(x, y, 300, wave.get(0));
  beginShape();
  for (int i = wave.size() -1; i >= 0 ; i--)
  {
    noFill();
    stroke(0,0,255);
    vertex(i + 300, wave.get(i));
  }
  endShape();
  strokeWeight(1);
  if(wave.size() > 900)
  {
    wave.remove(wave.size() -1);
  }
  wave.reverse();
  //@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ END_REVERSE
  
    sinWave.reverse(); //!!!!
  stroke(255,0,0);
  line(sinX, sinY, 300, sinWave.get(0));
  beginShape();
  for (int i = sinWave.size() -1 ; i >= 0; i--)
  {
     noFill();
    stroke(204, 0, 255);
    vertex(i + 300, sinWave.get(i));
  }
  endShape();
  if(sinWave.size() > 900)
  {
    sinWave.remove(wave.size() -1);
  }
  sinWave.reverse();//!!!!
  
  lastNtimes = Ntimes;
  
  time += 0.02;
}