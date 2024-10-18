Pod::Spec.new do |s|
  s.name             = 'github-sdk'
  s.version          = '0.1.0'
  s.summary          = 'SDK do desafio da Gazeus Games.'
  s.description      = <<-DESC
SDK do desafio da Gazeus Games.
                       DESC

  s.homepage         = 'https://github.com/lfsilva/github-sdk'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Leandro Fernandes' => 'lfsilva@me.com' }
  s.source           = { :git => 'https://github.com/lfsilva/github-sdk.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.source_files = 'github-sdk/Classes/**/*.{h,m}'
  s.public_header_files = 'github-sdk/Classes/Public/**/*.h'
  
  s.resource_bundles = {
      'github-sdk' => ['github-sdk/Assets/*.{xcassets}']
  }
  
  s.test_spec 'Tests' do |test_spec|
      test_spec.source_files = 'github-sdk/Tests/**/*.{h,m}'
  end
end
