// The men behind the desks
// by Federico Pepe
// http://www.federicopepe.com

RoviSearch thisRoviSearch;

Table index;

IntDict engineers = new IntDict();

int filterYear = 2015;

void setup() {
  size(500, 500);
  index = loadTable("resources/Index.csv", "header, csv");
  getData();
  // DEBUG AND TEST
  // Sort values by descending order
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
  
  for (int i = 0; i < index.getRowCount(); i++) {
    /*
      // Load columns from CSV File
     int year = index.getInt(i, "Year");
     int position = index.getInt(i, "Position");
     String album = index.getString(i, "AlbumTitle");
     String artist = index.getString(i, "ArtistName");
     println(year + " " + position + " " + album + artist);
    */
    int year = index.getInt(i, "Year");
    String roviAlbumId = index.getString(i, "RoviAlbumID");
    
    if(filterYear == year ) {
      
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
            if (artistCredits[z].equals("Mastering")) {
              engineers.increment(artistName);
            }
          }
        }
      }
    }
  }
}