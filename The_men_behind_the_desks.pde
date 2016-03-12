// The men behind the desks
// by Federico Pepe
// http://www.federicopepe.com
import java.net.URLEncoder;

JSONObject json;
int counter = 0;

RoviSearch thisRoviSearch;

String[] albums = {
  "1989", 
  "x", 
  "In the lonely hour", 
  "If you're reading this it's too late", 
  "Master of Puppets", 
  "Ride the lightning", 
  "Random access memories", 
  "Achtung Baby", 
  "Hometowns", 
  "Reflector", 
  "Birth of the Cool", 
  "Kind of Blue", 
  "A love supreme"
};

void setup() {
  thread("getData");
}

void draw() {
}

void getData() {
  for (int i = 0; i < 1; i++) {
    counter++;
    thisRoviSearch = new RoviSearch("album/info", "album", albums[i]);
    if (counter % 5 == 0) {
      println("W - A - I - T - I - N - G");
      //delay(5000);
    }
    if (thisRoviSearch.getData()) {
      println("=== DATA LOADED FOR: " + albums[i]);
    } else {
    }
  }
}