class ReportScraperController < ApplicationController
  def index
  end

  before_filter :add_reports

  # Web Scraper dependencies
  require 'rubygems'
  require 'nokogiri'
  require 'open-uri'

  # Scrapes www.columbuspolice.org/Reports/ for police reports to
  # add to the report database
  def add_reports

  	# URL of search results
  	url = 'http://www.columbuspolice.org/Reports/Results?from=12/1/2014&to=12/31/2014&loc=all&types=9'

  	# Get HTML with Nokogiri
  	html = Nokogiri::HTML(open(url))

  	# Extract table rows
  	rows = html.xpath('//tr[not(@class="pgr")]')

  	# Extract data from table columns
  	i = 0
  	rows.each do |row| 	
  		# Add report to database	
  		Report.create(:CRNumber => "#{row.xpath("//td")[i].content.strip}", \
  			:description  => "#{row.xpath("//td")[i + 1].content.strip}",   \
			:victim  => "#{row.xpath("//td")[i + 2].content.strip}",  		\
			:date  => "#{row.xpath("//td")[i + 3].content.strip}",          \
			:location  => "#{row.xpath("//td")[i + 4].content.strip}")      
  		i += 5

  		# Check report for arrestees
  		arrestURL = 'http://www.columbuspolice.org/Reports/PublicReport?caseID=4087103'
  	end

  end
	




  # Redirect to reports database
  # redirect_to 'http://localhost:3000/reports'

end
