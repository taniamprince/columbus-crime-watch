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
			when "551 - Criminal Damaging"
				report.update_attribute(:category, "Criminal Damaging")
			when "118 - Theft - From Motor Vehicle - Petit"
				report.update_attribute(:category, "Theft From Motor Vehicle (Petty)")
			when "117 - Theft - From Motor Vehicle - Felony"
				report.update_attribute(:category, "Theft From Motor Vehicle (Felony)")
			when "450 - Robbery"
				report.update_attribute(:category, "Robbery")
			when "255 - Menacing"
				report.update_attribute(:category, "Menacing")
			when "259 - Discharging Firearms"
				report.update_attribute(:category, "Discharging Firearms")
			when "254 - Assault"
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
			when "115 - Theft - Misdemeanor"
				report.update_attribute(:category, "Theft (Petty)")
			when "400 - Fraud"
				report.update_attribute(:category, "Fraud")
		end		
	end

  end

end
