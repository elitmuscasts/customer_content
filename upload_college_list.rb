#!/usr/bin/env ruby
# UPLOAD COLLEGE LIST AUTOMATOR
# Usage :
#   ruby upload_college_list.rb <input_file_path.csv> <output_file_path.html>
#   <input_file_path.csv> # input file must be a CSV with first column with heading 'College Name'
#   <output_file_path.html> # must be an html file
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
                                    <br/>
                                    <div id="custom-search-input">
                                       <div class="input-group col-md-12">
                                           <input type="text" id="search-input" class="form-control input-md" placeholder="search college name..." />
                                               <span class="input-group-btn">
                                                   <button class="btn btn-info btn-md" type="button">
                                                      <i class="glyphicon glyphicon-search"></i>
                                                    </button>
                                                </span>
                                        </div>
                                    </div>
                                    <br/>
                                    <div class="table-responsive">
                                        <table id="college-list" class="table table-striped table-hover table-condensed table-bordered">')
          
          # adding the colleges one by one
      idx = 0
		  csv_rows.each do |row|
            college_name = row['College Name']
            string = "<tr id='s_no_#{idx}'><td>#{idx+1}</td><td>#{college_name}</td></tr>\n"
            f.write (string)
            idx = idx + 1
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
    <script src="https://code.jquery.com/jquery-2.2.0.min.js"></script>
        <script>
        // search
        var college_list = {};
        $("#college-list tr").each(function(row, tr){
            college_list[row] = {
            "serial"        : $(tr).find("td:eq(0)").text()  // Serial No.
            , "college_name": $(tr).find("td:eq(1)").text()  // College Name
            }
        });

        console.log(college_list);

        $(document).ready(function(){
            $("#search-input").keyup(function(){
                 // Retrieve the input field text and reset the count to zero
                 var filter = $(this).val();
                 for (var key in college_list) {
                     if (college_list.hasOwnProperty(key)) {
                          var val = college_list[key];
                          if ((val.college_name.search(new RegExp(filter, "i")) < 0)){
                               $("#s_no_"+(val.serial-1)).fadeOut();


                           }
                           else{
                                $("#s_no_"+(val.serial-1)).show();
                           }

            }
        }
    })
});
    </script>
</html>')
        end
	end

convert_file(ARGV[0], ARGV[1])
