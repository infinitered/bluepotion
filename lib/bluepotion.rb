# encoding: utf-8

unless defined?(Motion::Project::Config)
  raise "This file must be required within a RubyMotion project Rakefile."
end

require 'bluepotion'

lib_dir_path = File.dirname(File.expand_path(__FILE__))
Motion::Project::App.setup do |app|
  files = [File.join(lib_dir_path, 'project/pro_motion/pm_application.rb')]
  files << [File.join(lib_dir_path, 'project/pro_motion/pm_screen.rb')]
  files << [File.join(lib_dir_path, 'project/pro_motion/pm_activity.rb')]
  files << [File.join(lib_dir_path, 'project/ruby_motion_query/rmq_stylesheet.rb')]
  files << Dir.glob(File.join(lib_dir_path, "project/**/*.rb"))
  files = files.flatten.uniq

  puts files.join("\n")
  puts "-" * 80

  app.files.unshift files
end
