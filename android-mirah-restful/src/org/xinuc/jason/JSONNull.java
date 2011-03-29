// Generated from JSONNull.mirah
package org.xinuc.jason;
public class JSONNull extends java.lang.Object {
  private static org.xinuc.jason.JSONNull NULL;
  public static org.xinuc.jason.JSONNull NULL() {
    if ((JSONNull.NULL != null)) {
      return JSONNull.NULL;
    }
    else {
      return JSONNull.NULL = new org.xinuc.jason.JSONNull();
    }
  }
  public java.lang.Object clone() throws java.lang.CloneNotSupportedException {
    return this;
  }
  public boolean equals(java.lang.Object object) {
    boolean __xform_tmp_1 = false;
    __xform_tmp_1 = (object == null);
    return __xform_tmp_1 ? (__xform_tmp_1) : (object instanceof org.xinuc.jason.JSONNull);
  }
  public java.lang.String toString() {
    return "null";
  }
}
