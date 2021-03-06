#
# Be sure to run `pod lib lint JSUtility.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'JSUtility'
    s.version          = '0.1.19'
    s.summary          = 'A large amount of utility classes to assist in iOS Development'

    # This description is used to generate tags and improve search results.
    #   * Think: What does it do? Why did you write it? What is the focus?
    #   * Try to keep it short, snappy and to the point.
    #   * Write the description between the DESC delimiters below.
    #   * Finally, don't worry about the indent, CocoaPods strips it!

    s.description      = <<-DESC
The reason for the development of this project is to assist development of iOS applications. From credit card verification, to ease of use with UI components. 
                       DESC

    s.homepage         = 'https://github.com/jsetting32/JSUtility'
    # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'John Setting' => 'jsetting32@yahoo.com' }
    s.source           = { :git => 'https://github.com/jsetting32/JSUtility.git', :tag => s.version.to_s }
    # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

    s.ios.deployment_target = '8.0'

    s.public_header_files = 'JSUtility/JSUtility.h'
    s.source_files = 'JSUtility/JSUtility.h'

    s.subspec 'Categories' do |ss|
        ss.public_header_files = 'JSUtility/*+*.h'
        ss.source_files = 'JSUtility/*+*.{h,m}'
    end

    s.subspec 'Classes' do |ss|
        ss.public_header_files = 'JSUtility/JS*.h'
        ss.source_files = 'JSUtility/JS*.{h,m}'
        ss.dependency 'JSUtility/Categories'
    end

    s.resources = 'JSUtility/Assets/{card_,stick_}*.{png,jpg,jpeg}'

#    s.source_files = 'JSUtility/Classes/**/*.{h,m}'

#    s.resources = 'JSUtility/**/*.{png,jpg,jpeg}'
    #s.resource_bundles = {
    #  'JSUtility' => ['JSUtility/Assets/*.png']
    #}

    # s.public_header_files = 'Pod/Classes/**/*.h'
    # s.frameworks = 'UIKit', 'MapKit'
    # s.dependency 'AFNetworking', '~> 2.3'
    s.requires_arc = true

end
