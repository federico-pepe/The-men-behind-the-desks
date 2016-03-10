/*
 * Rovi Search Class
 */

class RoviSearch {
  // --- VARIABLES
  String apiEndpoint;
  String queryParameter;
  String queryValue;

  JSONObject json;
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
    File f = new File(dataPath("data/" + queryValue + ".json"));
    if (f.exists()) {
      json = loadJSONObject("data/" + queryValue + ".json");
    } else {
      json = loadJSONObject(getQueryUrl());
      queryValue = json.getJSONObject("album").getJSONObject("ids").getString("albumId");
      saveJSONObject(json, "data/" + queryValue + ".json");
    }
    if (json != null) {
      return true;
    } else {
      return false;
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