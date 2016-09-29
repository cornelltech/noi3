var User = function(params) {
    this.first_name =  params.first_name,
    this.last_name =  params.last_name,
    this.email =  params.email,
    this.password =  params.password,
    this.picture_path = params.picture_path,
    this.position = params.position,
    this.organization = params.organization,
    this.organization_type = params.organization_type,
    this.city =  params.city,
    this.country =  params.country
    this.expertise =  params.expertise;
    this.main_expertise = params.main_expertise;
};

var Project = function(params) {
  this.title = params.title,
  this.description = params.description;
};

var Event = function(params) {
    this.conference_code = params.conference_code,
    this.name = params.name,
    this.logo_path = params.logo_path,
    this.date = params.date
};

var Categories = function(params) {
  this.name = params.name;
}

$(document).ready(function(){

  $('.person-item__credentials').on('click',function(e) {
    var target = $(this).attr('data-user');
    $.ajax({
      method: 'GET',
      url: '/search/' + target ,
      dataType: 'json'
    }).done(function(data) {
      var user = new User(data.user);
      renderUserProfile(user);
      renderUserProjects(data.projects);
      renderUserEvents(data.events);
      renderUserExpertisePanel(data.expertise);
      renderDomains(data.industries);
      renderMainExpertise(data.main_expertise);
    }).fail(function(err) {
      console.log(err);
    });
  });

});

function renderUserProfile(user) {
  $('.profile-panel__name').html(user.first_name + ' ' + user.last_name);
  $('.profile-panel__job').html(user.position);
  $('.profile-panel__org').html(user.organization);
  $('.profile-panel__location').html(user.city + ', ' + user.country);

}

function renderDomains(industries) {
  industriesArr = [];
  industries.forEach(function(industry) { industriesArr.push(industry.name ); });
// debugger
  $('.profile-panel__domains').html("Domains of Expertise: " +industriesArr.join(', '));
}

function renderUserEvents(events) {
  $('.events-container').html('');
  var eventsHtml = '';
  events.forEach(function(event) {
    eventsHtml += '<div class="event-panel__item">';
    eventsHtml += '<a href="#" target="_blank">';
    eventsHtml += '<img src="/assets/events/' + event.logo_path + '" alt="' + event.name + '">';
    eventsHtml += '</div>';
  });
  $('.events-container').html(eventsHtml);
}


function renderUserExpertisePanel(expertise) {
  $('.profile-panel__content .category-tags').html('');
  var expertiseHtml = '';
  if (expertise) {
    expertise.forEach(function(e) {
  // debugger
      expertiseHtml += '<li class="category-tag">';
      expertiseHtml += '<span class="category-tag__main">' + toTitleCase(e.category) + '</span> ';
        e.skill_areas.forEach(function(sa) {
          expertiseHtml += '<span class="category-tag__sub">' + toTitleCase(sa) + '</span> ';
        });
      expertiseHtml += '</li><li class="category-tag__skills">View Skills (' + e.skills.length + ')</li>';
    });
  }
  $('.profile-panel__content .category-tags').html(expertiseHtml);
}


function renderMainExpertise(expertise) {
  expertiseMainHtml = '';
  if (expertise) {
    expertise.forEach(function(e) {
      expertiseMainHtml += '<div class="expertise-panel__item">';
      expertiseMainHtml +=  '<h3 class="expertise-panel__main-category">' + e.category + '</h3>';
      expertiseMainHtml +=  '<section class="expertise-panel__question-group">';
      e.skill_areas.forEach(function(sa) {
        expertiseMainHtml += '<h4 class="expertise-panel__sub-category">'+ toTitleCase(sa.area_name) +'</h4>';
        sa.area_skills.forEach(function(skill) {
          expertiseMainHtml += '<p class="expertise-panel__question">' + capitalizeFirstLetter(skill) + '</p>';  
        });
      expertiseMainHtml  += '</section>'
      });  

      expertiseMainHtml += '</div>';
    });
  }
  $('.expertise-container').html(expertiseMainHtml);

}


function renderUserProjects(projects) {
  $('.projects-container').html('');
  var projectsHtml = '';
  projects.forEach(function(project) {
    projectsHtml += projectView(project);
  });

  $('.projects-container').html(projectsHtml);
}



function projectView(project) {
  var projectHtml = '<div class="project-panel__item">';
  projectHtml += '<h3 class="project-panel__title">' + project.project.title + '</h3>';
  projectHtml += '<a class="project-panel__url" href="#" target="_blank">' + project.project.url+ '</a>';
  projectHtml += '<ul class="person-item__tags category-tags category-tags--negative">';
  project.tags.forEach(function(p) {
  projectHtml += '<li class="person-item__tag category-tag"><span class="category-tag__main"> '+ toTitleCase(p.category) +'</span>';
    p.skill_areas.forEach(function(sa){
      projectHtml += '<span class="category-tag__sub"> ' + toTitleCase(sa) + '</span>';
    });
  });
  projectHtml += '</li><span class="industry-tag">' + project.industries + '</span>'
  projectHtml += '</ul><p>'+ project.project.description + '</p></div>';
  return projectHtml;
}


// helpers
function toTitleCase(str) {
  return str.replace(/\w\S*/g, function(txt){
    return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
  });
}


function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}




















