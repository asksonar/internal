$(function(){
  if (!$('#resolutions-show').length) {
    return;
  }

  var resolutionsController = new ResolutionsController({
    btnSaveResolution: $('#btn-save-resolution')
  });
});
