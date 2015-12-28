# -*- coding: utf-8 -*-
#$:.unshift("/Library/RubyMotion/lib")
# Currently only working with 3.13
$:.unshift("/Library/RubyMotion3.13/lib")
require 'motion/project/template/android'

require 'bundler'
Bundler.require

Motion::Project::App.setup do |app|
  # Use `rake config' to see complete project settings.
  app.api_version = "16"
  app.target_api_version = "16"

  app.archs = ["x86"] unless ARGV.include?("device") || ARGV.include?("spec:device") || ARGV.include?("release")

  app.name = 'BluePotion'
  app.package = "com.infinitered.bluepotion"
  app.theme = "@android:style/Theme.Holo.Light"
  app.permissions = [:internet, :access_network_state] # :access_coarse_location, :access_fine_location, :write_external_storage
  app.icon = 'ic_launcher'

  # Version name is for you - version code must always be higher in Google Play (tied to git builds)
  # app.version_name = "1.0.0"
  # app.version_code = (`git rev-list HEAD --count`.strip.to_i).to_s

  app.application_class = "BluePotionApplication"
  app.main_activity = "PMHomeActivity"
  app.sub_activities += %w(PMSingleFragmentActivity PMNavigationActivity)

  app.gradle do
    # Google's networking API for Android
    dependency "com.mcxiaoke.volley:library:1.0.10"

    # support lib
    dependency "com.android.support:support-v4:18.0.+"

    # pull to refresh
    dependency 'in.srain.cube:ultra-ptr:1.0.10'

    # Google's Android Play Services
    #dependency 'com.android.support:appcompat-v7:21.0.3'
    #dependency "com.google.android.gms:play-services-maps:7.3.0"
  end

  # TODO, figure out why fragments are being recreated when we allow landscape orientation
  app.manifest.child('application') do |application|
    application.children("activity").each do |activity|
      activity.update(
        "android:screenOrientation" => "portrait",
        "android:configChanges" => "orientation"
      )
    end
  end

end
