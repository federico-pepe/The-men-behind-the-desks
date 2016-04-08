// The men behind the desks
// by Federico Pepe
// http://www.federicopepe.com

RoviSearch thisRoviSearch;

Table index;

IntDict engineers = new IntDict();

int[] filterYears = {2015, 2014, 2013, 2012, 2011, 2010, 2009, 2008, 2007, 2006, 2005, 2004, 2003, 2002, 2001, 2000};
int filterYear = 2015;
int counter  = 0;

void setup() {
  size(500, 500);
  
  // Load some data
  index = loadTable("resources/Index.csv", "header, csv");
  getData();
  // DEBUG AND TEST
  // Sort values by descending order
  engineers.sortValuesReverse();
  println(engineers);
}

void draw() {
  
}

void mousePressed() {
  // On click change filterYear
  counter++;
  if(counter >= filterYears.length) {
    counter = 0;
  }
  filterYear = filterYears[counter];
  
  getData();
  println(engineers);
  
}

// Function: getData();
// Description: 
// Create a RoviSearch Object to obtain JSON data using Index.csv as reference
//
void getData() {
  // Clear intDict() data
  engineers.clear();
  
  // Start loading data from the Index CSV file
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