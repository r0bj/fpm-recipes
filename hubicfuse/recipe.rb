class Hubicfuse < FPM::Cookery::Recipe
	version '2.1.0'
	source   'https://github.com/TurboGit/hubicfuse', :with => :git, :tag => "v#{version}"

	name 'hubicfuse'

	def build
		configure
		make
	end

	def install
		sbin.install 'hubicfuse'
		sbin.install 'hubic_token'
  	end
end
