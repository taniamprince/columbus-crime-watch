class ReportCategoryController < ApplicationController
  def index
  end

  before_filter :categorize_reports

  # Checks each report for offense type and assigns a category to the
  # database. This makes the data much easier to display in graphs.
  def categorize_reports
  	@reports = Report.all
  	@reports.each do |report|
  		# Get crime description
  		description = report.description

  		# Assign crime category based on description
	  	case description
			when "118 - Theft - From Motor Vehicle - Petit"
				report.update_attribute(:category, "Theft From Motor Vehicle")
			when "117 - Theft - From Motor Vehicle - Felony"
				report.update_attribute(:category, "Theft From Motor Vehicle")
			when "450 - Robbery"
				report.update_attribute(:category, "Robbery")
			when "254 - Assault"
				report.update_attribute(:category, "Assault")
			when "262 - Felony Assault"
				report.update_attribute(:category, "Assault")
			when "200 - Motor Vehicle Theft"
				report.update_attribute(:category, "Motor Vehicle Theft")
			when "101 - Burglary - Zone 1"
				report.update_attribute(:category, "Burglary")
			when "102 - Burglary - Zone 2"
				report.update_attribute(:category, "Burglary")
			when "103 - Burglary - Zone 3"
				report.update_attribute(:category, "Burglary")
			when "104 - Burglary - Zone 4"
				report.update_attribute(:category, "Burglary")
			when "105 - Burglary - Zone 5"
				report.update_attribute(:category, "Burglary")
			when "300 - Rape/Sexual Assault Vic 16 Yr and Older"
				report.update_attribute(:category, "Rape")
			when "301 - Rape/Sexual Assault Vic 15 Yr and Younger"
				report.update_attribute(:category, "Rape")
			when "250 - Homicide"
				report.update_attribute(:category, "Murder")
		end

		# Get crime year
		year = ""
		if report.date.length == 10
			year = report.date[6..10]
		end

		# Update Year column from date
		report.update_attribute(:year, year)
	end

	redirect_to 'http://localhost:3000/admin'

  end

end
