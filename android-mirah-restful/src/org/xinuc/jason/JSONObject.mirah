package org.xinuc.jason

import java.util.Hashtable

class JSONObject
  def self.parse(token:JSONTokenizer):Hashtable throws JSONException
    hash = Hashtable.new
    raise token.error("Invalid: Must begin with '{'") unless token.nextClean == 123
    while true
      c = token.nextClean
      raise token.error("Invalid: Must end with '}'") if c == 0

      break if c == 125 # '}'

      token.back
      key = token.nextValue.toString
      c = token.nextClean
      raise token.error("Invalid: ':' expected after key '#{key}'") unless c == 58 # ':'

      #put the valid value into the hashtable
      hash.put(key, token.nextValue)

      c = token.nextClean
      break if c == 125 # '}'
      raise token.error("Expected a ',' or '}', got #{c}") unless c == 44 # ','
    end
    hash
  end

  def self.stringfy(hash:Hashtable):String
    ""
  end

end
