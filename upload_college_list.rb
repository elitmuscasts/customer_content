#!/usr/bin/env ruby
require 'csv'


	def convert_file(csv_file, to_file)

		csv_rows= CSV.read(csv_file,:headers => true , :encoding => 'ISO-8859-1')
        


		File.open(to_file,'w') do |f|
          # adding the header
          f.write('<!DOCTYPE html>
                    <html lang="en">
                      <head>
                        <meta name="viewport" content="width=device-width, initial-scale=1">
                        <!-- Latest compiled and minified CSS -->
                        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap.min.css">
                        <!-- Optional theme -->
                        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.2.0/css/bootstrap-theme.min.css">
                      </head>
                      <body>
                        <div class="container">
                            <div class="row">
                                <div class="col-md-offset-1"/>
                                <div class="col-md-10">
                                    <div class="table-responsive">
                                        <table class="table table-striped table-hover table-condensed table-bordered">')
          
          # adding the colleges one by one
		  csv_rows.each do |row|
            number = row['Serial #']
            college_name = row['College Name']
            string = "<tr><td>#{number}</td><td>#{college_name}</td></tr>"
            f.write (string)
		  end
          
          # adding the footer
          f.write('</table>
                    </div>
                </div>
                <div class="col-md-offset-1"/>
            </div>
            <div class="row">
                <div class="col-md-offset-1"/>
                <div class="col-md-8">
                    <a class="btn btn-danger btn-sm btn-block" role="button" onclick="javascript:window.close();">Close</a>
                </div>
                <div class="col-md-offset-1"/>
            </div>
        </div>
        </body>
')
        end
	end

convert_file(ARGV[0], ARGV[1])