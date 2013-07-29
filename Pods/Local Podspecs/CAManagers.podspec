Pod::Spec.new do |s|
	s.name = 'CAManagers'
	s.summary = 'Library for working with CA API'
	s.homepage = 'https://github.com/BrandyMint/CA-managers-lib'
	s.author = {
		'Igor Lepeshkin' => 'lis892009@yandex.ru'
	}
	s.source = {
		:git => 'https://github.com/BrandyMint/CA-managers-lib.git',
		:commit => '9b417bf537756e338e2f23030b14795c16bd2f4f'
	}
	s.platform = :ios, '5.0'
	s.source_files = 'CAManagersLib/CAManagersLib/Managers/**/*.{h,m}','CAManagersLib/CAManagersLib/Models/**/*.{h,m}'
	s.requires_arc = true
	s.dependency 'EasyMapping', '0.4.3'
	s.dependency 'LRResty', '0.11.0'
	s.dependency 'RestKit', '0.20.0'
	s.dependency 'Base64', '1.0.1'
	s.dependency 'FormatterKit', '1.2.0'
end
