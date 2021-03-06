Pod::Spec.new do |s|
	s.name					= "Liferay-iOS-SDK"
	s.version				= "6.2.0.6"
	s.summary				= "Build iOS apps for Liferay."
	s.homepage				= "https://www.liferay.com/community/liferay-projects/liferay-mobile-sdk"
	s.license				= {
								:type => "LPGL 2.1",
								:file => "ios/copyright.txt"
							}
	s.authors				= {
								"Bruno Farache" => "bruno.farache@liferay.com"
							}
	s.platform				= :ios
	s.ios.deployment_target = '6.1'
	s.source				= {
								:git => "https://github.com/liferay/liferay-mobile-sdk.git",
								:tag => "6.2.0.6"
							}
	s.source_files			= "ios/Source/**/*.{h,m}"
	s.resource_bundles		= {
								"Liferay-iOS-SDK" => [
									"ios/Source/Util/Localization/*.lproj"
								]
							}
	s.requires_arc			= true
	s.dependency			"AFNetworking", "~> 2.2.4"
end