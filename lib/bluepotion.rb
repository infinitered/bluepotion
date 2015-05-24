# encoding: utf-8

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require 'bluepotion'

lib_dir_path = File.dirname(File.expand_path(__FILE__))
Motion::Project::App.setup do |app|
  insert_point = app.files.find_index { |file| file =~ /^(?:\.\/)?app\// } || 0

  Dir.glob(File.join(lib_dir_path, "project/**/*.rb")).reverse.each do |file|
    app.files.insert(insert_point, file)
  end
end
