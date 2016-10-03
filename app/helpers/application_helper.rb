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

end
