require 'nokogiri'
require 'open-uri'
require 'json'

url = 'https://gamebiz.jp/article/category/22'
results = []

charset = nil
html = open(url) do |f|
  charset = f.charset
  f.read
end

doc = Nokogiri::HTML.parse(html, nil, charset)
doc.xpath('//div[@class="Article_Thumbs"]').each do |node|
	pic_url = node.children[1].attributes['src'].value
	title = node.children[1].attributes['alt'].value
  result = {
		pic_url: pic_url,
		title: title
	}
	results.push(result)
end

puts JSON.pretty_generate(results)
