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
    this.country =  params.country;
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
      renderUserExpertisePanel(data.categories);
    }).fail(function(err) {
      console.log(err);
    });
  });

});

function renderUserProfile(user) {
  $('.profile-panel__name').html(user.first_name + ' ' + user.last_name);
  $('.profile-panel__job').html(user.position);
  $('.profile-panel__org').html(user.organization);
  $('.profile-panel__location').html(user.city + ' ' + user.country);

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


function renderUserExpertisePanel(categories) {
  $('.profile-panel__content .category-tags').html('');
  var categoriesHtml = '';
  if (categories) {
    categories.forEach(function(category) {
      categoriesHtml += '<li class="category-tag">';
      categoriesHtml += '<span class="category-tag__main">' + toTitleCase(category.name) + '</span> ';
      categoriesHtml += '<span class="category-tag__sub">Implementation</span></li>';
      categoriesHtml += '<li class="category-tag__skills">View Skills (10)</li>';
    });
  }
  $('.profile-panel__content .category-tags').html(categoriesHtml += '<li class="category-tag__skills">View Skills (10)</li>');
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
  projectHtml += '<h3 class="project-panel__title">' + project.title + '</h3>';
  projectHtml += '<a class="project-panel__url" href="#" target="_blank">data.la.gov</a>';
  projectHtml += '<ul class="person-item__tags category-tags category-tags--negative">';
  projectHtml += '<li class="person-item__tag category-tag"><span class="category-tag__main">Open Data</span><span class="category-tag__sub">Implemenation</span></li>';
  projectHtml += '</ul><p>'+ project.description + '</p></div>';
  return projectHtml;
}


// helpers
function toTitleCase(str) {
  return str.replace(/\w\S*/g, function(txt){
    return txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase();
  });
}





















