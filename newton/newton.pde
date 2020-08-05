color[] colors;
color[] pastel = {#A7FFE4, #CDFFA7, #FFFAA7, #FFD0A7, #FFA7A7};
color[] neon = {#FF0092, #FFCA1B, #B6FF00, #228DFF, #BA01FF};
color[] muted = {#E6B39A, #E6CBA5, #EDE3B4, #8B9E9B, #6D7578};
color[] blues = {#CFF09E, #A8DBA8, #79BD9A, #3B8686, #0B486B, #e8facd};
color[] summer = {#B3CC57, #ECF081, #FFBE40, #EF746F, #AB3E5B};
color[] pinks = {#FCF2BF, #EBDDAC, #ECC3A7, #C99085, #A32F5C};
color[] bright = {#BCED1B, #FFF59B, #05A5AC, #F1DB0F, #128764};
color[] dark = {#020304, #541F14, #938172, #CC9E61, #626266};
color[] dusk = {#F0D8C0, #F0C0A8, #D8A8A8, #907890, #787890};


float startingExtent = 3;
float zoomLevel = 0.9;
float extent = startingExtent;
int maxIter = 100;
float tolerance = 0.0000001;

float ratio;
float left;
;
float right;
float top;
float bottom;

HashMap<String, Integer> roots;
int rootCount;

Boolean basins = false;
Boolean record = false;

class IterationResult {

  ComplexNumber c;
  int iter;

  IterationResult(int iter, ComplexNumber c) {
    this.c = c;
    this.iter = iter;
  }
}

// F = (x ^ 4 - 1) + x ^ 3
IterationResult newtonsMethod(ComplexNumber c) {
  int i = 0;
  while (i < maxIter) {
    // F(c)
    ComplexNumber numerator = c.pow(4.0).minus(1.0).plus(c.pow(3.0));
    // F'(c)
    ComplexNumber denominator = c.pow(3.0).times(4.0).plus(c.pow(2.0).times(3));
    ComplexNumber step = numerator.divideBy(denominator);
    if (step.abs() < tolerance || Double.isNaN(step.abs())) {
      break;
    }
    c = c.minus(step);
    i ++;
  }
  return new IterationResult(i, c);
}

IterationResult getPixelResult(int i, int j) {
  float x = map(i, 0, width, left, right);
  float y = map(j, 0, height, top, bottom);
  ComplexNumber z = new ComplexNumber(x, y);
  return newtonsMethod(z);
}

void display() {
  for (int i = 0; i < width; i ++) {
    for (int j = 0; j < height; j ++) {
      IterationResult result = getPixelResult(i, j);
      float hue = map(result.iter, 0, maxIter, 0, 360);
      color col = color((hue + 200) % 360, 50, 100, 100);
      set(i, j, col);
    }
  }
}

void displayBasins() {
  for (int i = 0; i < width; i ++) {
    for (int j = 0; j < height; j ++) {
      IterationResult result = getPixelResult(i, j);
      String root = result.c.round(1).toString();
      if (!roots.containsKey(root)) {
        roots.put(root, rootCount);
        rootCount ++;
      }
      color col = colors[(roots.get(root) + 0) % colors.length];
      set(i, j, col);
    }
  }
}

void keyPressed() {
  if (key == 'b' || key == 'B') {
    println("resetting");
    basins = !basins;
    reset();
  }

  if (key == 'r' || key == 'R') {
    println("recording starting");
    record = true;
  }
}

void reset() {
  extent = startingExtent;
  roots = new HashMap<String, Integer>();
  rootCount = 0;
}

void zoomin() {
  extent *= zoomLevel;
  left = - extent;
  right = extent;
  top = - ratio * extent;
  bottom = ratio * extent;
}

void setup() {
  colorMode(HSB, 360, 100, 100, 100);
  size(1000, 600);
  colors = blues;
  ratio = (1.0 * height) / width;
  roots = new HashMap<String, Integer>();
  rootCount = 0;
  left = - extent;
  right = extent;
  top = - ratio * extent;
  bottom = ratio * extent;
}

void draw() {
  if (basins) {
    displayBasins();
  } else {
    display();
  }
  if (record) {
    saveFrame("video/####-export.jpeg");
  }
  zoomin();
}
