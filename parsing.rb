require "nokogiri"
require "open-uri"
require_relative "recipe"

url = "https://www.allrecipes.com/search?q=chocolate"

html = URI.open(url).read

doc = Nokogiri::HTML(html, nil, "utf-8")

results = []

doc.search('.mntl-card-list-items').each do |element|
  unless element.search(".recipe-card-meta__rating-count").empty?
    name =  element.search('.card__title-text').text.strip
    rating = element.search(".icon-star").count + element.search(".icon-star-half").count * 0.5

    details_url = element.attribute("href").value
    details_html = URI.open(details_url).read
    details_doc = Nokogiri::HTML(details_html, nil, "utf-8")

    description = details_doc.search("h2").first.text.strip

    prep_time = "no prep time provided"

    details_doc.search(".mntl-recipe-details__item").each do |prep_details|
      unless prep_details.search('.mntl-recipe-details__label:contains("Prep Time:")').empty?
        prep_time = prep_details.search(".mntl-recipe-details__value").text.strip
      end
    end 
    results << Recipe.new(name, description, prep_time, rating)
  end
end

p results.first(5)