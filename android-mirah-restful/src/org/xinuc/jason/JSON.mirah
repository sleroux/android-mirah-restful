package org.xinuc.jason

import java.io.InputStream
import java.io.IOException

class JSON
  def self.parse(stream:InputStream):Object throws JSONException, IOException
    return parse(JSONUtils.streamToString(stream))
  end
  
  def self.parse(str:string):Object throws JSONException
    token = JSONTokenizer.new(str)
    c = token.nextClean
    if c == 123 # '['
      token.back
      return JSONObject.parse(token)
    end
    if c == 91 # '['
      token.back
      return JSONArray.parse(token)
    end
    raise token.error("Invalid JSON. It should be begin with a '{' or '['")
  end
end
