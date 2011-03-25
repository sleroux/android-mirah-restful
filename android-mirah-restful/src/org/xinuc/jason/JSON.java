// Generated from JSON.mirah
package org.xinuc.jason;
public class JSON extends java.lang.Object {
  public static java.lang.Object parse(java.io.InputStream stream) throws org.xinuc.jason.JSONException, java.io.IOException {
    return org.xinuc.jason.JSON.parse(org.xinuc.jason.JSONUtils.streamToString(stream));
  }
  public static java.lang.Object parse(java.lang.String str) throws org.xinuc.jason.JSONException {
    org.xinuc.jason.JSONTokenizer token = null;
    char c = 0;
    token = new org.xinuc.jason.JSONTokenizer(str);
    c = token.nextClean();
    if ((c == 123)) {
      org.xinuc.jason.JSONTokenizer temp$1 = token;
      temp$1.back();
      return org.xinuc.jason.JSONObject.parse(token);
    }
    if ((c == 91)) {
      org.xinuc.jason.JSONTokenizer temp$2 = token;
      temp$2.back();
      return org.xinuc.jason.JSONArray.parse(token);
    }
    throw token.error("Invalid JSON. It should be begin with a '{' or '['");
  }
}
