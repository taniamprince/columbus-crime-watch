class ReportScraperController < ApplicationController
  def index
  end

  before_filter :add_reports

  # Web Scraper dependencies
  require 'rubygems'
  require 'mechanize'
  require 'open-uri'

  # Scrapes www.columbuspolice.org/Reports/ for police reports to
  # add to the report database
  def add_reports

    # Get start date and end date
    startDate = params[:startDate]
    endDate = params[:endDate]

  	# Get HTML of page
  	agent = Mechanize.new
    html = agent.get 'http://columbuspolice.org/Reports/Results?from=' + startDate + '&to=' + endDate + '&loc=all&types=9'

    # Get number of records
    records = html.search('//span[@id="MainContent_lblCount"]')
    recordNum = records[0].content.strip.gsub(/[^0-9]/, '').to_i

    # Calculate page count. There is a max of 29 records per page.
    pageNum = (recordNum / 29).ceil

    # Keep track of which page we are on.
    position = 1

    # Scrape the pages
    loop do

        # Extract table rows. Exclude the last two pagination rows.
        rows = html.search("//tr[not(position() > last() - 2)]")

        # Extract data from table columns and add report to database.
        i = 0
        rows.each_with_index do |row|   
            Report.create(:CRNumber => "#{row.search("//td")[i].content.strip}", \
            :description  => "#{row.search("//td")[i + 1].content.strip}",       \
            :victim  => "#{row.search("//td")[i + 2].content.strip}",            \
            :date  => "#{row.search("//td")[i + 3].content.strip}",              \
            :location  => "#{row.search("//td")[i + 4].content.strip}")      
            i += 5
        end

         # Increment page position
        position = position + 1

        break if position > pageNum

        # Get next page
        form = html.form
        page = "Page$" + position.to_s
        form.add_field!('__EVENTARGUMENT', page)
        form.add_field!('__EVENTTARGET', 'ctl00$MainContent$gvResults')
        html = agent.submit(form)
     
    end

    redirect_to 'http://localhost:3000/admin'

  end

end
