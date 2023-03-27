double xmin = -2.5;
double ymin = -2;
double factor = 4;
int maxIterations = 80;
int fraktal = 0;
double zoomdepth = 0.1;
double scaleFactor = 0.1;
double movingfactor = 0.01;
double directionX, directionY, prevX, prevY, startfactor;
double mousefactor = 0.0;
boolean shift=false;
boolean update = true;

//julia mengen spezifisch
double cx = -0.535;//-0.7,-0.535,-1.77,-0.15652,0.27334,-0.783
double cy = 0.505;//0.27015,0.505,0.06,-1.03225,0.00742,0.138

//newton verfahren
ArrayList<Complexnumbers> roots = new ArrayList<Complexnumbers>();
//color[] colors = {color(255, 0, 0), color(0, 255, 0), color(0, 0, 255)}; 

double tempx, tempy;
int maxautozoom = 1000;

void setup() {
  roots.add(new Complexnumbers(1,0));
  roots.add(new Complexnumbers(-.5,sqrt(3)/2));
  roots.add(new Complexnumbers(-.5,-sqrt(3)/2));
  size(600,600);
  //fullScreen(1);
  colorMode(HSB, 255);
  loadPixels();
  noSmooth();
  
}

void draw() {
 if (update) {
   if (fraktal == 0) {
     newton();
   } else if (fraktal == 1) {
     julia();
   } else if (fraktal == 2) {
     mandelbrot();
   }
 }
 
 fill(0);
 textSize(20);
 text("Iterationen: " + str(maxIterations), 50, 50);
 String text = "";
 if (fraktal == 0) {
   text = "Newton";
 } else if (fraktal == 1) {
   text = "Julia-Menge";
 } else if (fraktal == 2) {
   text = "Mandelbrot";
 }
 text("Fraktal: " + text, 50, 70);
 //noch aktuelles fraktal hinschreiben
 //text("FPS: " + str(frameRate), 50, 70);
}

void keyPressed() {
    if (keyCode==SHIFT) shift=true;
    if (key=='z') {
      for (int i = 0; i < maxautozoom; i++) {
        double mx = (factor) / (width-1);
        // P1(0|-2) P2(599|2)
        // P1(0|ymin) P2((length-1)|(ymin+factor))
        // y-Achsenabschnitt: ymin
        double my = (factor) / (height-1);
        
        double mouseinimaginaerx = mx * tempx + xmin;
        double mouseinimaginaery = my * tempy + ymin;
        
        //println("X: " + str((float)mouseinimaginaerx) + " Y: " + str((float)mouseinimaginaery));
        //println("Xmin: " + str((float)xmin) + " Ymin: " + str((float)ymin) + " Factor: " +str((float)factor));
        
        
        factor *= 1 - (scaleFactor/100);
        xmin = (xmin - mouseinimaginaerx)*(1 - (scaleFactor/100)) + mouseinimaginaerx;
        ymin = (ymin - mouseinimaginaery)*(1 - (scaleFactor/100)) + mouseinimaginaery;
        maxIterations += 2;
        update = true;
      }
    }
    if (key == 'm'){
      if (fraktal == 0) {
         maxIterations = 200;
         fraktal = 1;
         update = true;
       } else if (fraktal == 1) {
         maxIterations = 80;
         fraktal = 2;
         update = true;
       } else if (fraktal == 2) {
         maxIterations = 80;
         fraktal = 0;
         update = true;
       }
    }
    switch (key) {
      case '-':
           xmin *= 1 + scaleFactor;
           ymin *= 1 + scaleFactor;
           factor *= 1 + scaleFactor;
           zoomdepth += scaleFactor;
           maxIterations -= (int)zoomdepth;
           update = true;
         break;
      case '+':
         xmin *= 1 - scaleFactor;
         ymin *= 1 - scaleFactor;
         factor *= 1 - scaleFactor;
         zoomdepth += scaleFactor;
         maxIterations += (int)zoomdepth;
         update = true;
         break;
      case 'h':
         xmin = -2.5;
         ymin = -2;
         factor = 4;
         if (fraktal == 0) {
           maxIterations = 80;
           
           update = true;
         } else if (fraktal == 1) {
           maxIterations = 200;
           
           update = true;
         }
         break;
      case '1':
        cx = -0.535;//-0.7,-0.535,-1.77,-0.15652,0.27334,-0.783
        cy = 0.505;//0.27015,0.505,0.06,-1.03225,0.00742,0.138
        update = true;
        break;
      case '2':
        cx = -0.7;//-0.7,-0.535,-1.77,-0.15652,0.27334,-0.783
        cy = 0.27015;//0.27015,0.505,0.06,-1.03225,0.00742,0.138
        update = true;
        break;
      case '3':
        cx = -1.77;//-0.7,-0.535,-1.77,-0.15652,0.27334,-0.783
        cy = 0.06;//0.27015,0.505,0.06,-1.03225,0.00742,0.138
        update = true;
        break;
      case '4':
        cx = -0.15652;//-0.7,-0.535,-1.77,-0.15652,0.27334,-0.783
        cy = -1.03225;//0.27015,0.505,0.06,-1.03225,0.00742,0.138
        update = true;
        break;
      case '5':
        cx = -0.27334;//-0.7,-0.535,-1.77,-0.15652,0.27334,-0.783
        cy = 0.00742;//0.27015,0.505,0.06,-1.03225,0.00742,0.138
        update = true;
        break;
      case '6':
        cx = -0.783;//-0.7,-0.535,-1.77,-0.15652,0.27334,-0.783
        cy = 0.138;//0.27015,0.505,0.06,-1.03225,0.00742,0.138
        update = true;
        break;
      case '7':
        
        break;
      case '8':
        
        break;
      case '9':
        
        break;
    }
    switch (keyCode) {
      case UP:
        ymin -= movingfactor;
        update = true;
        break;
      case DOWN:
        ymin += movingfactor;
        update = true;
        break;
      case LEFT:
        xmin -= movingfactor;
        update = true;
        break;
      case RIGHT:
        xmin += movingfactor;
        update = true;
        break;
      
    }
}

void mousePressed() {
  directionX = mouseX;
  directionY = mouseY;
  prevX = xmin;
  prevY = ymin;
  startfactor = factor;
  tempx = mouseX;
  tempy = mouseY;
}

void keyReleased() {
  if (keyCode==SHIFT) shift=false;
}

void mouseDragged() {
  double deltaX=(mouseX-directionX)/width;
  double deltaY=(mouseY-directionY)/height;
  xmin = prevX-deltaX*factor;
  ymin = prevY-deltaY*factor;
  update = true;
}

void mouseWheel(MouseEvent event) {
  double e = event.getCount(); 
  
  // P1(0|-2.5) P2(599|1.5)
  // P1(0|xmin) P2((width-1)|(xmin+factor))
  // y-Achsenabschnitt: xmin
  double mx = (factor) / (width-1);
  // P1(0|-2) P2(599|2)
  // P1(0|ymin) P2((length-1)|(ymin+factor))
  // y-Achsenabschnitt: ymin
  double my = (factor) / (height-1);
  
  double mouseinimaginaerx = mx * mouseX + xmin;
  double mouseinimaginaery = my * mouseY + ymin;
  
  //println("X: " + str((float)mouseinimaginaerx) + " Y: " + str((float)mouseinimaginaery));
  //println("Xmin: " + str((float)xmin) + " Ymin: " + str((float)ymin) + " Factor: " +str((float)factor));
  
  if (e < 0.0) {
    //reinzoomen
    factor *= 1 - scaleFactor;
    xmin = (xmin - mouseinimaginaerx)*(1 - scaleFactor) + mouseinimaginaerx;
    ymin = (ymin - mouseinimaginaery)*(1 - scaleFactor) + mouseinimaginaery;
    maxIterations += 2;
    update = true;
  } else {
    //rauszoomen
    factor *= 1 + scaleFactor;
    xmin = (xmin - mouseinimaginaerx)*(1 + scaleFactor) + mouseinimaginaerx;
    ymin = (ymin - mouseinimaginaery)*(1 + scaleFactor) + mouseinimaginaery;
    if (maxIterations > 20) {
      maxIterations -= 2;
    }
    update = true;
  }
  //println("Xmin: " + str((float)xmin) + " Ymin: " + str((float)ymin) + " Factor: " +str((float)factor));
}

void julia() {
  update = false;
  double xmax = xmin + factor;
  double ymax = ymin + factor;
  
  double dx = (xmax-xmin) / width;
  double dy = (ymax-ymin) / height;
  
  double y = ymin;
  for (int p = 0; p < height; p++) {
    double x = xmin;
    for (int i = 0; i < width; i++) {
      double a = y;
      double b = x;
      int iteration = 0;
      while (iteration < maxIterations) {
        double sqquarea = a * a;
        double squareb = b * b;
        b = 2.0 * a * b + cy;
        a = sqquarea - squareb + cx;
        
        
        if (sqquarea + squareb > 16.0) break;
        iteration++;
      }
      
      pixels[i+p*width] = (iteration==maxIterations) ? color(0) : color(iteration*16 % 255, 255, 255);
      
      x += dx;
    }
    y += dy;
  }
  updatePixels();
}

void mandelbrot() {
  update = false;
  double xmax = xmin + factor;
  double ymax = ymin + factor;
  
  double dx = (xmax-xmin) / width;
  double dy = (ymax-ymin) / height;
  
  double y = ymin;
  for (int p = 0; p < height; p++) {
    double x = xmin;
    for (int i = 0; i < width; i++) {
      double a = x;
      double b = y;
      int iteration = 0;
      while (iteration < maxIterations) {
        double squarea = a * a ;
        double squareb = b * b ;
        b = 2.0 * a * b + y;
        a = (squarea - squareb) + x;
        if (squarea + squareb > 16.0) break;
        iteration++;
      }
      
      pixels[i+p*width] = (iteration==maxIterations) ? color(0) : color(iteration*16 % 255, 255, 255);
      
      x += dx;
    }
    y += dy;
  }
  updatePixels();
}

Complexnumbers derivate(Complexnumbers z) {
  return Complexnumbers.cmulfactor(Complexnumbers.cmul(z,z),3);
}

Complexnumbers function(Complexnumbers z) {
    Complexnumbers temp = new Complexnumbers(1, 0);
    return Complexnumbers.csub(Complexnumbers.cmul(Complexnumbers.cmul(z,z),z),temp);
}

color newtonfunction(Complexnumbers z) {
  for (int iteration = 0; iteration < maxIterations; iteration++) {
      double a = 1;
      z = Complexnumbers.csub(z, (Complexnumbers.cmulfactor(Complexnumbers.cdiv(function(z), derivate(z)),a)));
      
      float tolerance = 0.000001;
      
      for (int o = 0; o < roots.size(); o++) {
        Complexnumbers difference = new Complexnumbers();
        Complexnumbers root = roots.get(o);
        
        difference = Complexnumbers.csub(z, root);
        
        if(abs((float)difference.getRe()) < tolerance && abs((float)difference.getIm()) < tolerance) {
          //println(i, p, o, iteration);
          return color((iteration+o)*16 % 255, 255, 255);
        }
      }
    }
    return color(0,0,0);
}

void newton() {
  update = false;
  double xmax = xmin + factor;
  double ymax = ymin + factor;
  
  double dx = (xmax-xmin) / width;
  double dy = (ymax-ymin) / height;
  
  double y = ymin;
  for (int p = 0; p < height; p++) {
    double x = xmin;
    for (int i = 0; i < width; i++) {
      double zx = x;
      double zy = y;
      Complexnumbers z = new Complexnumbers(zx, zy);
      
      pixels[i+p*width] = color(0,0,0);
      pixels[i+p*width] = newtonfunction(z);
      //pixels[i+p*width] = color(0,0,0);
      
      //pixels[i+p*width] = (iteration==maxIterations) ? color(0) : color(iteration*16 % 255, 255, 255);
      x += dx;
      
    }
    y += dy;
    
  }
  updatePixels();
}
