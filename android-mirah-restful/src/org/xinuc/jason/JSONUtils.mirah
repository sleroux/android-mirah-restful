package org.xinuc.jason

import java.io.InputStream
import java.io.StringWriter
import java.io.IOException
import java.io.Writer
import java.io.Reader
import java.io.BufferedReader
import java.io.InputStreamReader

class JSONUtils
  def self.streamToString(stream:InputStream):String throws IOException
    if stream != null
      writer = StringWriter.new
      buffer = char[1024]

      begin
        reader = BufferedReader.new(InputStreamReader.new(stream, "UTF-8"))
        numReadBytes = reader.read(buffer)
        while numReadBytes != -1
          writer.write(buffer, 0, numReadBytes)
          numReadBytes = reader.read(buffer)
        end
      ensure
        stream.close()
      end

      return writer.toString()
    else
      return ""
    end
  end
end


