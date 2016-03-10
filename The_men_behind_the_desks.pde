// The men behind the desks
// by Federico Pepe
// http://www.federicopepe.com
import java.net.URLEncoder;

String queryID = "1989";
JSONObject json;

RoviSearch thisRoviSearch;

String[] albums = {"1989", "x", "In the lonely hour", "If you're reading this it's too late"};

void setup() {
  for (int i = 0; i < albums.length; i++) {
    thisRoviSearch = new RoviSearch("album/info", "album", albums[i]);
    if (thisRoviSearch.getData()) {
      println("Ok");
    }
  }
}

void draw() {
}