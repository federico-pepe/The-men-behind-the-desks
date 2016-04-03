// The men behind the desks
// by Federico Pepe
// http://www.federicopepe.com

JSONObject json;
RoviSearch thisRoviSearch;

Table billboard;

void setup() {
  billboard = loadTable("resources/Index.csv");
  getData();
}

void draw() {
}

void getData() {
  for (int i = 1; i < billboard.getRowCount(); i++) {
    int year = billboard.getInt(i, 0);
    int position = billboard.getInt(i, 1);
    String album = billboard.getString(i, 2);
    String artist = billboard.getString(i, 3);
    String roviAlbumId = billboard.getString(i, 4);
    thisRoviSearch = new RoviSearch("album/info", "albumid", roviAlbumId);
    /*
      Uncomment this to avoid hitting API call limits.
      if (counter % 5 == 0) {
      println("W - A - I - T - I - N - G");
      delay(1200);
    }
    */
    if (thisRoviSearch.getData()) {
      println(i);
    }
  }
}