package org.xinuc.jason

class JSONNull

  def self.NULL
    @@NULL ||= JSONNull.new
  end

  def clone
    self
  end

  def equals(object:Object)
    return object == null || object.kind_of?(JSONNull)
  end

  def toString
    "null"
  end
end
