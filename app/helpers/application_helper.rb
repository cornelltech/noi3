module ApplicationHelper


  def format_skills(skills_array)
    # Skills formatting in the /matches
    # Formatting an array of can_teach and can_learn skills from the current user and each user in the DB. Similar formatting in user#format_expertise
    # [{:category=>"citizen science", :skill_areas=>[], :skills=>["ensure sustainability of project management", "communicate results and milestones to participants"]}, {:category=>"crowdsourcing", :skill_areas=>[], :skills=>[" use the crowd to evaluate the crowd contributions (through voting,rating or peer-review)"]}, {:category=>"open data", :skill_areas=>[], :skills=>["measure the economic and/or social impact of opening up data"]}]
    skillsets = []
    skills_array.each do | skill | 
      skillsets.push({category: Skill.find(skill).category.name, skills:[]}).uniq!
    end
    skills_array.each do |skill| 
      skillsets.each do |skillset|
        if Skill.find(skill).category.name == skillset[:category]
          skillset[:skills] << Skill.find(skill).description
        end
      end
    end
    skillsets
  end

	def current_class?(test_path)
		puts request.path
		return 'main-menu__item--active' if request.path == test_path
		''
	end


  def sortable(column, title = nil)
    # uses users#sort_column and users#sort_direction to determine column and direction
    title ||= column.titleize
    css_class = column == sort_column ? "current #{sort_direction}" : nil
    direction = column == sort_column && sort_direction == "asc" ? "desc" : "asc"
    sort_params = search_params
    sort_params[:sort] = column
    sort_params[:direction]= direction
    link_to title, sort_params, {:class => css_class}
  end

  def new_sign_up
    session[:new_user]
  end

  private


  def search_params
    # save search params and add sort and direction
    sort_params = {:utf8 => '✓'}
    permitted_params = [:search_string,:category,:skill_area,:industry,:country,:language, :event]
    permitted_params.each do |val|
      sort_params[val] = params[val]
    end 
    sort_params
  end



end
