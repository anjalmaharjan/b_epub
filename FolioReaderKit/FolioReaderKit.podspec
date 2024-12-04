Pod::Spec.new do |spec|
    spec.name         = 'FolioReaderKit'
    spec.version      = '1.0.3'
    spec.summary      = 'A simple EPUB reader.'
    spec.description  = 'FolioReaderKit is an EPUB reader framework.'
    spec.homepage     = 'https://github.com/anjalmaharjan/FolioReaderKit'
    spec.license      = { :type => 'MIT', :file => 'LICENSE' }
    spec.author       = { 'Your Name' => 'your.email@example.com' }
    spec.source       = { :git => 'https://github.com/anjalmaharjan/FolioReaderKit.git', :tag => spec.version.to_s }
    spec.platform     = :ios, '12.0'
    spec.source_files = 'Sources/**/*.{h,m,swift}'
    spec.requires_arc = true
  end
  