package org.xinuc.jason

class JSONException < Exception
  def initialize(message:String)
    super message
  end
end
