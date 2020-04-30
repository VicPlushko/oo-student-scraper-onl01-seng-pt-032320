require 'open-uri'
require 'pry'

class Scraper

  def self.scrape_index_page(index_url)
    student_array = []
    html = Nokogiri::HTML(open(index_url))
    html.css(".student-card").collect do |student|
      student_info = {
      name: student.css("h4.student-name").text,
      location: student.css("p.student-location").text,
      profile_url: "https://learn-co-curriculum.io" + student.css("a").attribute("href")
      }
      student_array << student_info
    end
      student_array
  end

  def self.scrape_profile_page(profile_url)
    
  end

end

