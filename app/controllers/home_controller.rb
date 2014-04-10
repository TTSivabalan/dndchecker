class HomeController < ApplicationController
  def index
  	
  end

  def check
  	mobile_number = params[:mobile_number]
  	if mobile_number.present? and mobile_number.size == 10
	  	begin
	  		response = RestClient.get("http://www.dndstatus.com/dnd-check-process.php?num=#{mobile_number}")
	  		page = Nokogiri::HTML(response.body)
	  		res = page.css("table tr")[2].text
	  		arr = res.split(" ")
	  		hash = { mobile_number: mobile_number, operator: arr[5], circle: arr[6], status: arr[0], dateOfActivation: arr[1], preference: "#{arr[3]} #{arr[4]}"}
	  		render json: hash	
	  	rescue Exception => e
	  		render json: {status: "Forbidden.."}
	  	end
	  else
	  	flash[:notice] = "Please enter Correct Mobile Number."
	  	redirect_to root_url
	  end
  end

  def api
  	mobile_number = params[:mobile_number]
  	if mobile_number.present? and mobile_number.size == 10
	  	begin
	  		response = RestClient.get("http://www.dndstatus.com/dnd-check-process.php?num=#{mobile_number}")
	  		page = Nokogiri::HTML(response.body)
	  		res = page.css("table tr")[2].text
	  		arr = res.split(" ")
	  		hash = { mobile_number: mobile_number, operator: arr[5], circle: arr[6], status: arr[0], dateOfActivation: arr[1], preference: "#{arr[3]} #{arr[4]}"}
	  		render json: hash	
	  	rescue Exception => e
	  		render json: {message: "Forbidden.."}
	  	end
	  else
	  	render json: {message: "Incorrect Mobile Number"}
	 	end	
  end

end
