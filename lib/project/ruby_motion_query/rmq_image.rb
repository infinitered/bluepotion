class RMQ
  # @return [RMQImageUtils]
  def self.image
    RMQImageUtils
  end

  # @return [RMQImageUtils]
  def image
    RMQImageUtils
  end
end

class RMQImageUtils
  class << self
    DEFAULT_IMAGE_EXT = 'png'

    # @return [UIImage]
    def resource(file_base_name, opts = {})
      ext = opts[:ext] || DEFAULT_IMAGE_EXT
      #cached = opts[:cached]
      #cached = true if cached.nil?

      constant = R::Drawable.const_get(file_base_name.capitalize)
      constant
      #if cached
        ##UIImage.imageNamed("#{file_base_name}.#{ext}")
      #else
        #R::Drawable::Foo
        #R::Drawable::Bluepotion_logo
        #file_base_name << '@2x' if RMQ.device.retina?
        #file = NSBundle.mainBundle.pathForResource(file_base_name, ofType: ext)
        #UIImage.imageWithContentsOfFile(file)
      #end
    end
  end
end

__END__


A 48x48 image, should be in these sizes (3:4:6:8):


drawable-hdpi
drawable-ldpi
drawable-mdpi
drawable-xhdpi
drawable-xxhdpi


http://labs.rampinteractive.co.uk/android_dp_px_calculator/

http://romannurik.github.io/AndroidAssetStudio/nine-patches.html
