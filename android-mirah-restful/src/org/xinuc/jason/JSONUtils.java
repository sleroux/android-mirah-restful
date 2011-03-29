// Generated from JSONUtils.mirah
package org.xinuc.jason;
public class JSONUtils extends java.lang.Object {
  public static java.lang.String streamToString(java.io.InputStream stream) throws java.io.IOException {
    java.io.StringWriter writer = null;
    char[] buffer = null;
    java.io.BufferedReader reader = null;
    int numReadBytes = 0;
    if ((stream != null)) {
      writer = new java.io.StringWriter();
      buffer = new char[1024];
      try {
        reader = new java.io.BufferedReader(new java.io.InputStreamReader(stream, "UTF-8"));
        numReadBytes = reader.read(buffer);
        label1:
        while ((numReadBytes != -1)) {
          label2:
           {
            java.io.StringWriter temp$3 = writer;
            temp$3.write(buffer, 0, numReadBytes);
            numReadBytes = reader.read(buffer);
          }
        }
      }
      finally {
        java.io.InputStream temp$4 = stream;
        temp$4.close();
      }
      return writer.toString();
    }
    else {
      return "";
    }
  }
}
