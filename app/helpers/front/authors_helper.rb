module Front::AuthorsHelper
	def body_class
		if params[:action].include? 'show'
  		'experience layout-with-footer-fixed-bottom'
  	else
  		'experience'
  	end
  end
end
