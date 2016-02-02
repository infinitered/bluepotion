<p align="center"><img src="http://s3.amazonaws.com/ir_public/projects/redpotion/BluePotion_logo_500w.png" alt="logo" width="250px"></p>

<br />

BluePotion
-----------

BluePotion is maintained by ![Infinite Red](http://infinite.red), a web and mobile development company based in Portland, OR and San Francisco, CA.

## Prerequisites

  - RubyMotion android: `motion android-setup` (install API 16)
  - Gradle: `brew install gradle`
  - GenyMotion Emulator (optional) [Gant Laborde's post on Genymotion](http://www.iconoclastlabs.com/blog/rubymotion-android-in-the-emulator-with-genymotion).
  - For running on your device, [do this](http://www.kingoapp.com/root-tutorials/how-to-enable-usb-debugging-mode-on-android.htm)

## Warning, BluePotion is an alpha release.

BluePotion is the Android version of [RedPotion](http://redpotion.org). We're spending a lot of time working on it right now. It's currently in Alpha.

We are building RMQ Android, ProMotion Android, and BluePotion all at once, and they all are inside BluePotion.

We're supporting Android XML layouts, using RMQ stylesheets the standard Android way, and eventually an exact copy of RedPotion's layout system.

Many things work, but there is a lot to do, so use it at your own risk.

To try it out:

```
gem install bluepotion
bluepotion create myapp
cd myapp
bundle
brew install gradle # if gradle is not installed. Requires homebrew
rake gradle:install

# Start your Genymotion virtual device or plug in your Android device

rake newclear
```

In your REPL, do this for fun:

```
rmq.log_tree
find(Potion::View).log
# etc
```

If you haven't setup Android yet, read this first: [Gant Laborde's post on Genymotion](http://www.iconoclastlabs.com/blog/rubymotion-android-in-the-emulator-with-genymotion).


Contributing

0. Create an issue in GitHub to make sure your PR will be accepted.
1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Write tests for your changes
4. Make your changes
5. Document your changes in the `docs` folder
6. Commit your changes (`git commit -am 'Add some feature'`)
7. Push to the branch (`git push origin my-new-feature`)
8. Create new Pull Request
