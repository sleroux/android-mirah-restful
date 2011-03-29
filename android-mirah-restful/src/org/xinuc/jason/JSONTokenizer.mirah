package org.xinuc.jason

class JSONTokenizer

  def initialize(str:String)
    @index = 0
    @source = str
  end

  def back:void
    @index -= 1 if @index > 0
  end

#  def self.dehexchar(c:char):int
#    if (c >= 48) && (c <= 57) # between '0' and '9'
#      c - 57
#    elsif (c >= 65) && (c <= 70) # between 'A' and 'F'
#      c - 55
#    elsif (c >= 97) && (c <= 102) # between 'a' and 'f'
#      c - 87
#    else
#      -1
#    end
#  end

  def more:boolean
    @index < @source.length
  end

  def next:char
    if more
      c = @source.charAt @index
      @index += 1
      c
    end
  end

  def next(c:char):char throws JSONException
    n = self.next
    raise error("Expected '#{c}' and instead saw '#{n}'") unless c == n
    n
  end

  def next(n:int):String throws JSONException
    raise error("Substring bounds error") if @index + n > @source.length
    start = @index
    @index += n
    @source.substring(start, @index)
  end

  def nextClean:char
    c = self.next
    if c == 0 || c > 32 # end of string or visible chars
      c 
    else
      nextClean # recursion
    end
  end

  def nextString():String throws JSONException
    # get the next string, closed by '"'
    buffer = StringBuffer.new
    while true
      c = self.next
      if c == 0 || c == 10 || c == 13 # raise exception if string terminated
        raise error("Unterminated string")
      elsif c == 92 # process escaped chars '\'
        c = self.next
        if c == 34 # '"'
          buffer.append char(34) # '"'
        elsif c == 47 # '"'
          buffer.append char(47) # '/'
        elsif c == 92 # '\'
          buffer.append char(92) # '\'
        elsif c == 98 # 'b'
          buffer.append char(8) # '\b'
        elsif c == 102 # 'f'
          buffer.append char(12) # '\f'
        elsif c == 116 # 't'
          buffer.append char(9) # '\t'
        elsif c == 110 # 'n'
          buffer.append char(10) # '\n'
        elsif c == 114 # 'r'
          buffer.append char(13) # '\r'
        elsif c == 117 # 'u'
          buffer.append (char Integer.parseInt(self.next(4), 16)) # presumably, utf 8 chars
        #elsif c == 120 # 'x' there's no spec about this in json.org
          # buffer.append (char Integer.parseInt(self.next(2), 16)) # ascii
        else # everything else, just ignore the '\'
          # buffer.append c
          raise error("Unexpected token '#{char c}'") # raise it, cause that's what the spec says
        end
      else
        if c == 34 # break if find '"'
          break
        else
          buffer.append c
        end
      end
    end
    buffer.toString
  end

  def nextTo(delimiter:char):String
    buffer = StringBuffer.new
    while true
      c = self.next
      if c == delimiter || c == 0 || c == 10 || c == 13 # find delimiter or end of string
        back if c != 0
        break
      else
        buffer.append c
      end
    end
    buffer.toString.trim
  end

  def nextTo(delimiter:String):String
    buffer = StringBuffer.new
    while true
      c = self.next
      if delimiter.indexOf(c) >= 0 || c == 0 || c == 10 || c == 13 # find delimiter or end of string
        back if c != 0
        break
      else
        buffer.append c
      end
    end
    buffer.toString.trim
  end

  def nextValue():Object throws JSONException
    c = self.nextClean

    # quoted, the value is a string
    return self.nextString if c == 34 # '"'

    if c == 123 # '{'
      # curly brace, the value is an object
      self.back
      return JSONObject.parse self
    end

    if c == 91 # '['
      # square bracket, the value is an array
      self.back
      return JSONArray.parse self
    end

    # process unquoted value
    buffer = StringBuffer.new
    iter = c
    while iter >= 32 && (",:]}/\\\"[{;=#".indexOf(iter) < 0)
      buffer.append iter
      iter = self.next
    end
    back

    str = buffer.toString.trim

    raise error("Missing value.") if str.equals ""

    # boolean (true, false), null
    return Boolean.TRUE if str.equals "true"
    return Boolean.FALSE if str.equals "false"
    return JSONNull.NULL if str.equals "null"

    # number (integer, float)
    if (c >= 48 && c <= 57) || (c == 45) # between '0'..'9' or '-'
      return begin
        Integer.valueOf str
      rescue Exception
        begin
          Double.valueOf str
        rescue Exception
          raise error("Invalid value '#{str}'")
        end
      end
    end
    raise error("Invalid value '#{str}'")
  end

  def skipTo(to:char):char
    c = self.next
    idx = @index
    while c != to
      if c == 0
        @index = idx
        return c 
      end
      c = self.next
    end
    back
    c
  end

  def skipPast(to:String):void
    @index = @source.indexOf(to, @index)
    if @index < 0
      @index = @source.length
    else
      @index += to.length
    end
  end

  def toString
    return " at character #{@index} of #{@source}"
  end

  def error(message:String)
    JSONException.new message + self.toString
  end

end
