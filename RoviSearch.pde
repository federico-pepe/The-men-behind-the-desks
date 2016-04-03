/*
 * Rovi Search Class
 * by Federico Pepe
 *
 * March 2016
*/
 
import java.net.URLEncoder;


class RoviSearch {
  // --- VARIABLES
  String apiEndpoint;
  String queryParameter;
  String queryValue;

  // --- CONSTANTS
  String apiKey = APIKey;
  String baseURL = "http://api.rovicorp.com/data/v1.1/";
  String apiFormat = "json";
  String valueEncoded = "";

  // --- CONSTRUCTORS
  RoviSearch() {
    apiEndpoint = "album/info";
    queryParameter = "album";
    queryValue = "1989";
  }

  RoviSearch(String _apiEndpoint, String _queryParameter, String _queryValue) {
    apiEndpoint = _apiEndpoint;
    queryParameter = _queryParameter;
    queryValue = _queryValue;
  }

  boolean getData() {
    //json = loadJSONObject(getQueryUrl());
    //return true;
    File f = new File(dataPath(apiEndpoint + queryValue + ".json"));
    if (f.exists()) {
      json = loadJSONObject("data/" + apiEndpoint + "/" + queryValue + ".json");
      return true;
    } else {
      json = loadJSONObject(getQueryUrl());
      if(json != null) {
        saveJSONObject(json, "data/" + apiEndpoint + "/" + queryValue + ".json");
        return true;
      } else {
        return false;
      }
    }
  }

  String getQueryUrl() {
    String albumUrl;
    Signature sig = new Signature();
    try {
      valueEncoded = URLEncoder.encode(queryValue, "UTF-8");
    }
    catch (Exception e) {
    }
    albumUrl = baseURL + apiEndpoint + "?" + "apikey=" + apiKey + "&sig=" + sig.getSignature() + "&" + queryParameter + "=" + valueEncoded + "&include=all&format=" + apiFormat;
    return albumUrl;
  }
}