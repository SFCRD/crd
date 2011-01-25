#!/usr/bin/env ruby -wKU

$: << File.join( File.dirname( __FILE__ ), 'lib' )
$: << File.join( File.dirname( __FILE__ ), 'test' )

desc "Runs the test suite"
task :test do
  require 'test_helper'
end

__END__
# sandbox below here

require 'crd'

main = Crd::Spec.new 'Main' do |s|
  s.input 'Main.as'
  s.output 'Main.swf'
  
  s.source_path <<
end

desc "Compiles the Main spec"
task :compile do
  Crd::Flex4::Mxmlc.new main do |c|
    
    
    
  end
end