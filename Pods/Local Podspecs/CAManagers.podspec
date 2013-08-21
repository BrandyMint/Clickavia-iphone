Pod::Spec.new do |s|
	s.name = 'CAManagers'
	s.summary = 'Library for working with CA API.'
	s.homepage = 'https://github.com/BrandyMint/CA-managers-lib'
	s.author = {
		'Igor Lepeshkin' => 'lis892009@yandex.ru'
	}
	s.source = {
		:git => 'https://github.com/BrandyMint/CA-managers-lib.git',
		:commit => '5546c80ab20fd916b7a38143ad128d07eb89d562'
	}
	s.platform = :ios, '5.0'
	s.source_files = 'CAManagersLib/**/*.{h,m}'
	s.requires_arc = true
	s.dependency 'EasyMapping', '0.4.3'
	s.dependency 'LRResty', '0.11.0'
	s.dependency 'RestKit', '0.20.0'
	s.dependency 'Base64', '1.0.1'
end
