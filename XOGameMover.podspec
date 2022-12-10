Pod::Spec.new do |spec|

spec.name = 'XOGameMover'
spec.version = '1.0.0'
spec.author = 'Katya A.'
spec.license = { :type => 'MIT', :text => <<-LICENSE
                   Copyright 2012
                   Permission is granted to ...
			 LICENSE
                }
spec.homepage = 'https://github.com/avraemenko/XOGameMover'
spec.source = { :git => 'https://github.com/avraemenko/XOGameMover.git', :tag => '1.0.0' }
spec.summary = 'This is my new framework. Enjoy!'

spec.swift_version = '5.7'
spec.platform = :ios, '13'

spec.source_files = 'Sources/XOGameMover/*'

end

