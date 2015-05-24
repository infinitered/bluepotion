# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/android'

require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.api_version = "16"
  app.development { app.archs << "x86" } # for genymotion support

  app.name = 'BluePotion'
  app.package = "com.infinitered.bluepotion"
  app.theme = "@android:style/Theme.Holo.Light"
  #app.permissions = [:internet, :access_network_state, :access_coarse_location, :access_fine_location, :write_external_storage]
  #app.version_name = "0.0.2"
  app.icon = 'ic_launcher'

  app.application_class = "BluePotionApplication"
  app.main_activity = "PMHomeActivity"
  app.sub_activities += %w(PMSingleFragmentActivity)
end
