Pod::Spec.new do |s|
  s.name             = 'FileLiner'
  s.version          = '1.0.0'
  s.summary          = 'Helps to read a file line by line.'
  s.description      = 'Helps to read a file line by line. Uses FileHandle to read the file.'

  s.homepage         = 'https://github.com/ethemozcan/FileLiner'
  s.social_media_url = 'https://linkedin.com/in/ethemozcan'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ethem Özcan' => 'ethemozcan@gmail.com' }
  s.source           = { :git => 'https://github.com/ethemozcan/FileLiner.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '8.0'

  s.source_files = 'Sources/FileLiner/**/*'

end
