/*
 * Rovi Search Class
 * by Federico Pepe
 *
 * March 2016
 */

import java.net.URLEncoder;


class RoviSearch {
  // --- VARIABLES
  // 
  String apiEndpoint;
  String queryParameter;
  String queryValue;

  // --- CONSTANTS
  // 
  String apiKey = APIKey;
  String baseURL = "http://api.rovicorp.com/data/v1.1/";
  String apiFormat = "json";
  

  // --- CONSTRUCTORS for Rovi Search
  // 
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
  
  // getData();
  // @returns JSONObject with data in it.
  JSONObject getData() {
    
    JSONObject jsonData;
    
    File f = new File(dataPath(apiEndpoint + "/" + queryValue + ".json"));
    if (f.exists()) {
      jsonData = loadJSONObject("data/" + apiEndpoint + "/" + queryValue + ".json");
    } else {
      jsonData = loadJSONObject(getQueryUrl());
      // To avoid reaching API call limit, uncomment the following line
      // saveJSONObject(json, "data/" + apiEndpoint + "/" + queryValue + ".json");
    }
    return jsonData;
  }
    
  // getQueryUrl();
  // @returns String encoded URL
  String getQueryUrl() {
    String queryUrl;
    String valueEncoded = "";
    Signature sig = new Signature();
    try {
      valueEncoded = URLEncoder.encode(queryValue, "UTF-8");
    }
    catch (Exception e) {
    }
    queryUrl = baseURL + apiEndpoint + "?" + "apikey=" + apiKey + "&sig=" + sig.getSignature() + "&" + queryParameter + "=" + valueEncoded + "&include=all&format=" + apiFormat;
    return queryUrl;
  }
}