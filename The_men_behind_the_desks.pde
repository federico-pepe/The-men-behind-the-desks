// The men behind the desks
// by Federico Pepe
// http://www.federicopepe.com

RoviSearch thisRoviSearch;

Table index;

IntDict engineers = new IntDict();

void setup() {
  index = loadTable("resources/Index.csv");
  getData();
  // DEBUG AND TEST
  engineers.sortValuesReverse();
  println(engineers);
}

void draw() {
}

// Function: getData();
// Description: 
// Create a RoviSearch Object to obtain JSON data using Index.csv as reference
//
void getData() {
  for (int i = 1; i < index.getRowCount(); i++) {
    /*
      // Load columns from CSV File
     int year = index.getInt(i, 0);
     int position = index.getInt(i, 1);
     String album = index.getString(i, 2);
     String artist = index.getString(i, 3);
     */
    String roviAlbumId = index.getString(i, 4);
    println(i);
    thisRoviSearch = new RoviSearch("album/info", "albumid", roviAlbumId);
    JSONObject json = thisRoviSearch.getData();
    // DEBUG and TESTING
    // println(json.getJSONObject("album").getJSONArray("credits"));
    if (!json.getJSONObject("album").isNull("credits")) {
      JSONArray albumCredits = json.getJSONObject("album").getJSONArray("credits");

      for (int j = 0; j < albumCredits.size(); j++) {
        JSONObject thisObject = albumCredits.getJSONObject(j);
        //String artistID = thisObject.getString("id");
        String artistName = thisObject.getString("name");
        String[] artistCredits = split(thisObject.getString("credit"), ", ");
        for (int z = 0; z < artistCredits.length; z++) {
          if (artistCredits[z].equals("Mixing")) {
            engineers.increment(artistName);
          }
        }
      }
    }
  }
}