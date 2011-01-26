#!/usr/bin/env ruby -wKU

class Symbol
  def assign?
    to_s[ -1 ].chr.eql? '='
  end
  def base
    to_s.sub( /=$/, '' ).to_sym
  end
end

class String
  def slug
    self.downcase.gsub( /\W+/, '-' ).gsub( /(^-|-$)/, '' )
  end
end