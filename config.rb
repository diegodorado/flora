### 
# Compass
###

# Change Compass configuration
compass_config do |config|
  #config.images_dir = "assets/images"
  config.output_style = :expanded
  config.relative_assets = true
  config.line_comments = true
  config.sass_options = {:debug_info => true}
end

activate :livereload

activate :asset_hash , :exts =>  %w(.js .css)
###
# Page command
###

# Per-page layout changes:
# 
# With no layout
#page "/test.html", :layout => false
page "/template.xml", :layout => false
page "/p/que-hace-esta-chica.html", :proxy => "/que-hace.html"
page "/search/label/biblioteca", :proxy => "/biblioteca.html"
page "/search/label/portfolio", :proxy => "/portfolio.html"
page "/p/flora-va-de-compras.html", :proxy => "/compras.html"


# 
# With alternative layout
# page "/path/to/file.html", :layout => :otherlayout
# 
# A path which all have the same layout
# with_layout :admin do
#   page "/admin/*"
# end

# Proxy (fake) files
#page "/onthecornerba.blogspot.com.xml", :proxy => "/template.xml" do
#   @which_fake_page = "Rendering a fake page with a variable"
#end

###
# Helpers
###

# Methods defined in the helpers block are available in templates
helpers do
  def some_helper
    "Helping"
  end
end


module MyAssetHandler
  class << self
    def registered(app)
      app.send :include, InstanceMethods
    end
    alias :included :registered
  end

  module InstanceMethods
    def asset_url(path, prefix="")
      original = super(path, prefix)
      #"http://localhost:4567" + original
      "http://onthecorner.com.ar/flora-assets" + original
    end
  end
end



#activate :relative_assets
#activate :asset_hash

# Build-specific configuration
configure :build do

  #activate only on build
  activate MyAssetHandler
  
  compass_config do |config|
    config.output_style = :compact
    config.asset_host do |asset|
      "http://onthecorner.com.ar/flora-assets"
    end
    config.relative_assets = false
    config.line_comments = false
    config.sass_options = {:debug_info => false}
  end

  # For example, change the Compass output style for deployment
  #activate :minify_css
  
  # Minify Javascript on build
  #activate :minify_javascript
  
  # Enable cache buster
  # activate :cache_buster
  
  # Use relative URLs
  # activate :relative_assets
  
  # Compress PNGs after build
  # First: gem install middleman-smusher
  # require "middleman-smusher"
  # activate :smusher
  
  # Or use a different image path
  #set :http_path, "http://localhost:4567"
end
