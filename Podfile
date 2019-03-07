# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
use_frameworks!

def network_pod
    pod 'Alamofire'
end

def image_pod
    pod 'Kingfisher'
    pod 'ImageViewer', :git => 'https://github.com/MailOnline/ImageViewer.git', :commit => 'ffe41dffb2ec0d6506d622b10099dc5e5eaeea43'
end


target 'FlickerSampleApp' do
    network_pod
    image_pod
end


target 'FlickerSampleAppTests' do
inherit! :search_paths
network_pod
end
