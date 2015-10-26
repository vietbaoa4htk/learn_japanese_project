module UserGoalsHelper
	def out_of_date?(days_left)
		days_left <= 0
	end
end
