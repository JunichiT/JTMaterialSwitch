# Podspec  JTMaterialSwitch 

Pod::Spec.new do |s|
  s.name             = "JTMaterialSwitch"
  s.version          = "1.0.0"
  s.summary          = "A customizable switch UI inspired from Google's Material Design."

  s.description      = <<-DESC
   `JTMaterialSwitch` is google's material design like switch UI with animation features. 
   This library has cool and sophisticated animations, ripple effect and bounce effect. Also, customizable properties can be tweaked behaviors and enhance your application UI cool. 
   With this library, you can easily implement material design switch to your app. 
                       DESC

  s.homepage         = "https://github.com/JunichiT/JTMaterialSwitch"
  s.screenshots     = "https://raw.githubusercontent.com/JunichiT/JTMaterialSwitch/master/Docs/switches.gif"
  s.license          = 'MIT'
  s.author           = { "Junichi Tsurukawa" => "j.tsurukawa@gmail.com" }
  s.source           = { :git => "https://github.com/JunichiT/JTMaterialSwitch.git", :tag => s.version.to_s }

  s.platform     = :ios, '7.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'JTMaterialSwitch' => ['Pod/Assets/*.png']
  }
  
end
