require "rubygems"
require "json"
require "fileutils"
require "safe_yaml"
require "htmlentities"

coder = HTMLEntities.new

file = open("textpattern.json")
json = file.read

parsed = JSON.parse(json)

parsed.each do |post|
  if (post['Status'] == '4' || post['Status'] == '5') && post['Section'] == 'clanky'
    # Get required fields and construct Jekyll compatible name.
    title = post['Title']
    slug = post['url_title']
    date = post['Posted']
    content = coder.decode(post['Body'])
    excerpt = coder.decode(post['Excerpt_html']).gsub!(/<("[^"]*"|'[^']*'|[^'">])*>/, '')
    image = post['Image']

    name = [post['feed_time'], slug].join('-') + ".md"

    # Get the relevant fields as a hash, delete empty fields and convert
    # to YAML for the header.
    data = {
       'layout' => 'post',
       'title' => title.to_s,
       'date' => date,
       'tags' => post['Keywords'].split(','),
       'image' => image
     }.delete_if { |k,v| v.nil? || v == ''}.to_yaml

    # Write out the data and content to file.
    File.open("_posts/#{name}", "w") do |f|
      f.puts data
      f.puts "---"
      f.puts excerpt
      f.puts ""
      f.puts content
    end
  end
end
