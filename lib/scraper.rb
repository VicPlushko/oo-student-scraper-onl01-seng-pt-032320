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
      profile_url: student.css("a").attribute("href").value
      }
      student_array << student_info
    end
      student_array
  end

  def self.scrape_profile_page(profile_url)
    html = open(profile_url)
    doc = Nokogiri::HTML(html)
    student_hash = {}
    link = doc.css(".vitals-container .social-icon-container a")
    
    link.each do |element|
      if element.attr("href").include?("twitter")
        student_hash[:twitter] = element.attr('href')
      elsif element.attr("href").include?("linkedin")
        student_hash[:linkedin] = element.attr("href")
      elsif element.attr("href").include?("github")
        student_hash[:github] = element.attr("href")
      elsif element.attr("href").include?("com/")
      student_hash[:blog] = element.attr("href")
      end
    end
    
    student_hash[:profile_quote] = doc.css(".vitals-container .vitals-text-container .profile-quote").text
    student_hash[:bio] = doc.css(".bio-block.details-block .bio-content.content-holder .description-holder p").text
    
    student_hash
  end

end

