# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/android'

require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.api_version = "16"
  app.target_api_version = "16"

  app.archs = ["x86"] unless ARGV.include?("device") || ARGV.include?("archive")

  app.name = 'BluePotion'
  app.package = "com.infinitered.bluepotion"
  app.theme = "@android:style/Theme.Holo.Light"
  app.permissions = [:internet, :access_network_state] # :access_coarse_location, :access_fine_location, :write_external_storage
  #app.version_name = "0.0.2"
  app.icon = 'ic_launcher'

  app.application_class = "BluePotionApplication"
  app.main_activity = "PMHomeActivity"
  app.sub_activities += %w(PMSingleFragmentActivity PMNavigationActivity)

  app.gradle do
    # Google's networking API for Android
    dependency "com.mcxiaoke.volley", :artifact => "library", :version => "1.0.10"

    # support lib
    dependency "com.android.support", artifact: "support-v4", version: "18.0.+"

    # Google's Android Play Services
    #dependency 'com.android.support', :artifact => 'appcompat-v7', :version => '21.0.3'
    #dependency "com.google.android.gms", :artifact => "play-services-maps", :version => "7.3.0"
  end
end
