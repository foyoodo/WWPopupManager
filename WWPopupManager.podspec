Pod::Spec.new do |spec|

  spec.name         = "WWPopupManager"
  spec.version      = "0.0.1"
  spec.summary      = "WWPopupManager is a manager to manage popupView and popupViewController."

  spec.homepage     = "https://github.com/foyoodo/WWPopupManager"

  spec.license      = "MIT"

  spec.author             = { "foyoodo" => "foyoodo@gmail.com" }
  spec.social_media_url   = "https://twitter.com/foyoodo"

  spec.ios.deployment_target = "9.0"

  spec.source       = { :git => "https://github.com/foyoodo/WWPopupManager.git", :tag => "#{spec.version}" }

  spec.requires_arc = true
  spec.source_files  = 'WWPopupManager/*.{h,m,mm}'
  spec.libraries = 'c++.1'

end
