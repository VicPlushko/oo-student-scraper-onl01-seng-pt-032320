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
    student_hash = {}
    html = Nokogiri::HTML(open(profile_url))
    html.css("div.social-icon-controler a").each do |student|
        url = student.attribute("href")
        student_hash[:twitter_url] = url if url.include?("twitter")
        student_hash[:linkedin_url] = url if url.include?("linkedin")
        student_hash[:github_url] = url if url.include?("github")
        student_hash[:blog_url] = url if student.css("img").attribute("src").text.include?("rss")
    end
        student_hash[:profile_quote] = html.css(".profile-quote").text
        student_hash[:bio] = html.css("div.bio-content p").text
        student_hash
  end

end

