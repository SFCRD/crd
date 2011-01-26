#!/usr/bin/env ruby -wKU

require 'crd'

Dir[ File.dirname( __FILE__ ) + '/crd/**/test_*.rb' ].each { |t| require t }