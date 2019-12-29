Pod::Spec.new do |s|
  s.name         		= 'iOS-WebP-redistributed'
  s.platform     		= 'ios'
  s.license      		= 'MIT'
  s.version      		= '0.5r'
  s.homepage     		= 'https://github.com/lucatk/iOS-WebP'
  s.summary     		= 'WebP image decoder and encoder for iOS'
  s.author       		= { 'Sean Ooi' => 'sean.ooi@me.com', 'Luca Killmaier' => 'lucakillmaier@lu-co.de' }
  s.source       		= { :git => 'https://github.com/lucatk/iOS-WebP.git', :tag => '0.5r' }
  s.source_files		= 'iOS-WebP/*.{h,m}'
  s.requires_arc		= true
  s.dependency      'libwebp', '~> 0.5.0'
end
