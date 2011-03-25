// Generated from JSONObject.mirah
package org.xinuc.jason;
public class JSONObject extends java.lang.Object {
  public static java.util.Hashtable parse(org.xinuc.jason.JSONTokenizer token) throws org.xinuc.jason.JSONException {
    java.util.Hashtable hash = null;
    char c = 0;
    java.lang.String key = null;
    hash = new java.util.Hashtable();
    if ((token.nextClean() == 123)) {
    }
    else {
      throw token.error("Invalid: Must begin with '{'");
    }
    label1:
    while (true) {
      label2:
       {
        c = token.nextClean();
        if ((c == 0)) {
          throw token.error("Invalid: Must end with '}'");
        }
        if ((c == 125)) {
          break label1;
        }
        org.xinuc.jason.JSONTokenizer temp$3 = token;
        temp$3.back();
        key = token.nextValue().toString();
        c = token.nextClean();
        if ((c == 58)) {
        }
        else {
          throw token.error("Invalid: ':' expected after key '" + key + "'");
        }
        hash.put(key, token.nextValue());
        c = token.nextClean();
        if ((c == 125)) {
          break label1;
        }
        if ((c == 44)) {
        }
        else {
          throw token.error("Expected a ',' or '}', got " + c);
        }
      }
    }
    return hash;
  }
  public static java.lang.String stringfy(java.util.Hashtable hash) {
    return "";
  }
}
