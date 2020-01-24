Pod::Spec.new do |s|
  s.name             = 'FileLiner'
  s.version          = '1.0.0'
  s.summary          = 'Helps to read a file line by line.'
  s.description      = 'Helps to read a file line by line. Uses FileHandle to read the file.'

  s.homepage         = 'https://github.com/ethemozcan/FileLiner'
  s.license          = 'MIT'
  s.author           = { 'Ethem Özcan' => 'ethemozcan@gmail.com' }
  s.source           = { :git => 'https://github.com/ethemozcan/FileLiner.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '8.0'
  s.swift_versions = '5.0'
  s.source_files = 'Sources/FileLiner/**/*'

end
