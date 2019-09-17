import gab.opencv.*;
import processing.video.*;
import java.awt.*;
 
Capture video;
 
OpenCV opencv;
Detector detector;
 
 
PImage pstImage;
 
void setup() {
  size(640, 480);
  video = new Capture(this, 640, 480);
  opencv = new OpenCV(this, 640, 480);
  detector = new Detector();
 
 
  noFill();
  smooth();
  video.start();
}
 
void draw() {
  opencv.loadImage(video);
 
  image(video, 0, 0 );
  noFill();
  strokeWeight(1);
 
  detector.update(OpenCV.CASCADE_FRONTALFACE, 1, 0, 255, 0);
  detector.update(OpenCV.CASCADE_EYE, 2, 255, 0, 0);
  detector.update(OpenCV.CASCADE_NOSE, 3, 0, 0, 255);
  detector.update(OpenCV.CASCADE_MOUTH, 4, 255, 0, 255);
}
 
void captureEvent(Capture c) {
  c.read();
}
 
 
class Detector {
 
  Detector() {
  }
 
  void update(String cascade, int column, int R, int G, int B) {
    opencv.loadCascade(cascade);
    Rectangle[] objects = opencv.detect();
    String objName[] = split(cascade, "_");
    String fancyName[] = split(objName[objName.length - 1], ".");
 
    for ( int i=0; i<objects.length; i++ ) {
      stroke(R, G, B);
      rect( objects[i].x, objects[i].y, objects[i].width, objects[i].height );
      textSize(11);
      text(fancyName[0]+": "+objects[i].width, column*70, (i+1)*10);
    }
  }
}
