// Generated from JSONArray.mirah
package org.xinuc.jason;
public class JSONArray extends java.lang.Object {
  public static java.util.Vector parse(org.xinuc.jason.JSONTokenizer token) throws org.xinuc.jason.JSONException {
    java.util.Vector array = null;
    char c = 0;
    array = new java.util.Vector();
    if ((token.nextClean() == 91)) {
    }
    else {
      throw token.error("Invalid: Must begin with '['");
    }
    if ((token.nextClean() == 93)) {
      return array;
    }
    org.xinuc.jason.JSONTokenizer temp$1 = token;
    temp$1.back();
    label2:
    while (true) {
      label3:
       {
        java.util.Vector temp$4 = array;
        temp$4.addElement(token.nextValue());
        c = token.nextClean();
        if ((c == 93)) {
          break label2;
        }
        if ((c == 44)) {
        }
        else {
          throw token.error("Expected a ',' or ']', got " + c);
        }
      }
    }
    return array;
  }
}
