#!/usr/bin/env ruby -wKU

$: << File.join( File.dirname( __FILE__ ), 'lib' )
$: << File.join( File.dirname( __FILE__ ), 'test' )

desc "Runs the test suite"
task :test do
  require 'test_helper'
end

require 'crd'

@spec = Crd::Spec.new 'Testing' do |s|
  s.input = 'Mock.as'
  s.output = 'Output.swf'
end

desc "Mocks out a quick test document class"
task :mock do
  doc =<<EOS
package
{
  import flash.display.Sprite;
  
  public class Mock extends Sprite
  {
    public function Mock( )
    {
      super( );
      
      trace( 'HOLY POOP' );
      
      graphics.beginFill( 0xff0000 );
      graphics.drawRect( 10, 10, 100, 100 );
      graphics.endFill( );
    }  
  }
}
EOS
  File.open 'Mock.as', 'w' do |f|
    f << doc
  end
end

desc "Trying out the mxmlc task"
task :compile => :mock do
  Crd::Flex::Mxmlc.new( @spec ) do |c|
    c.debug = true
    c.run!
  end
  `open #{@spec.output.filename}`
end

__END__
# sandbox below here

require 'crd'

main = Crd::Spec.new 'Main' do |s|
  s.input = 'Main.as'
  s.output = 'Main.swf'
  
  s.source_path <<
end

desc "Compiles the Main spec"
task :compile do
  Crd::Flex::Mxmlc.new main do |c|
    
    c.static_link_runtime_shared_libraries = true
    
    c.run!
  end
end