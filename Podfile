# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ConvertCurrency' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ConvertCurrency
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'Alamofire'
  post_install do |installer|
    # ios deployment version
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
        config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
        config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
        xcconfig_relative_path = "Pods/Target Support Files/#{target.name}/#{target.name}.#{config.name}.xcconfig"
        file_path = Pathname.new(File.expand_path(xcconfig_relative_path))
        next unless File.file?(file_path)
        configuration = Xcodeproj::Config.new(file_path)
        next if configuration.attributes['LIBRARY_SEARCH_PATHS'].nil?
        configuration.attributes['LIBRARY_SEARCH_PATHS'].sub! 'DT_TOOLCHAIN_DIR', 'TOOLCHAIN_DIR'
        configuration.save_as(file_path)
      end
    end
  end
end
