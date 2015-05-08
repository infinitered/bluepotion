# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require 'motion/project/template/android'

begin
  require 'bundler'
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.name = 'BluePotion'
  app.package = "com.infinitered.bluepotion"
  app.application_class = "BluepotionApplication"
  app.theme = "@android:style/Theme.Holo.Light"

  app.api_version = "16"
  app.development { app.archs << "x86" } # for genymotion support

  app.main_activity = "PMHomeActivity"
  app.sub_activities += %w(PMSingleFragmentActivity)

end
