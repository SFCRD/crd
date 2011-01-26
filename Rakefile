#!/usr/bin/env ruby -wKU

$: << File.join( File.dirname( __FILE__ ), 'lib' )
$: << File.join( File.dirname( __FILE__ ), 'test' )

desc "Runs the test suite"
task :test do
  require 'test_helper'
end

require 'crd'

spec = Crd::Spec.new 'Main', '0.0.1' do |s|
  s.input   = 'src/Main.as'
  s.output  = 'src/Output.swf'
end

desc "Compiles something"
task :compile do
  mxmlc spec
end

desc "Generates documentation"
task :asdoc do
  asdoc spec do |c|
    c.output = 'src/docs'
  end
end

desc "Generates SWC"
task :swc do
  compc spec
end

desc "Generates manifest XML"
task :manifest do
  manifest spec
end

namespace :kick do
  desc "Kicks some ass"
  task :ass => [ :manifest, :compile, :asdoc, :swc ]
end