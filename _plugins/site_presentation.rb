# Load site-owned presentation once, in the head of every HTML page.
# A content hash refreshes the stylesheet whenever its contents change.
require 'digest'

Jekyll::Hooks.register :pages, :post_render do |page|
  next unless page.output_ext == '.html'

  stylesheet = File.join(page.site.source, 'assets/css/academic.css')
  next unless File.file?(stylesheet)

  version = Digest::SHA256.file(stylesheet).hexdigest[0, 12]
  baseurl = page.site.config['baseurl'].to_s.sub(%r{/$}, '')
  link = %(<link rel="stylesheet" href="#{baseurl}/assets/css/academic.css?v=#{version}" data-site-presentation="shared">)
  page.output = page.output.sub('</head>', "#{link}</head>")
end
