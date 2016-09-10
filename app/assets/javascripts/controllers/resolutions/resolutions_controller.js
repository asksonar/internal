ResolutionsController = function(config) {
  this.$btnSaveResolution = config.btnSaveResolution;

  this.init();
};

ResolutionsController.prototype.init = function() {
  this.$btnSaveResolution.on('click', $.proxy(this.saveResolution, this));
};

ResolutionsController.prototype.saveResolution = function() {
  var thisEl = $(event.currentTarget);
  var resolutionId = thisEl.attr('data-resolution-id');
  var updateType = thisEl.attr('data-update-type');
  var options = {};

  var approve = $('input[type=radio][value=approve]:checked');
  var reject = $('input[type=radio][value=reject]:checked');

  if (approve.length && reject.length) {
    options[updateType] = {};

    $.each(approve, function(key, value) {
      var attribute = $(value).closest('.resolution-attribute');
      var attributeName = attribute.attr('data-attribute-name');
      var attributeValue = attribute.attr('data-attribute-value');
      options[updateType][attributeName] = attributeValue;
    });
    
    this.applyResolution(resolutionId, options)
  } else if (approve.length) {
    this.applyResolution(resolutionId, options)
  } else if (reject.length) {
    this.rejectResolution(resolutionId)
  }
};

ResolutionsController.prototype.applyResolution = function(id, options) {
  $.ajax({
    type: 'POST',
    data: options,
    url: 'http://webservices-env.m4edbzxi9e.us-west-2.elasticbeanstalk.com/resolutionSvc/queue/' + id,
    success: function(response) {
      debugger
      window.location.replace('/resolutions');
    }.bind(this),
    error: function(jqXHR) {
      debugger
    }.bind(this)
  });
};

ResolutionsController.prototype.rejectResolution = function(id) {
  $.ajax({
    type: 'POST',
    data: {
      _method: 'DELETE'
    },
    url: 'http://webservices-env.m4edbzxi9e.us-west-2.elasticbeanstalk.com/resolutionSvc/queue/' + id,
    success: function(response) {
      debugger
      window.location.replace('/resolutions');
    }.bind(this),
    error: function(jqXHR) {
      debugger
    }.bind(this)
  });
};
