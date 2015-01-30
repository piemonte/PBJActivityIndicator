Pod::Spec.new do |s|
  s.name = 'PBJActivityIndicator'
  s.version = '0.2.2'
  s.summary = 'iOS component for efficient status bar activity indication.'
  s.homepage = 'https://github.com/piemonte/PBJActivityIndicator'
  s.social_media_url = 'http://twitter.com/piemonte'
  s.license = 'MIT'
  s.authors = { 'patrick piemonte' => 'piemonte@alumni.cmu.edu' }
  s.source = { :git => 'https://github.com/piemonte/PBJActivityIndicator.git', :tag => 'v0.2.2' }
  s.platform = :ios, '6.0'
  s.source_files = 'Source'
  s.requires_arc = true
  s.screenshot = 'https://raw.github.com/piemonte/PBJActivityIndicator/master/PBJActivityIndicator.gif'
end
