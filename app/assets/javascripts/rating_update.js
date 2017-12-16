function HandleAjaxRequest(form) {
  this.formElement = form;
}

HandleAjaxRequest.prototype.init = function () {
  this.ajaxSuccessRequest();
  this.ajaxErrorRequest();
};

HandleAjaxRequest.prototype.ajaxSuccessRequest = function() {
  _this = this;
  console.log(this);
  console.log(this.formElement)
  this.formElement.on("ajax:success", function(event, data, status, xhr) {
    alert('Product successfully rated');
    console.log(data);
    console.log(event);
    console.log(status);
  });
};

HandleAjaxRequest.prototype.ajaxErrorRequest = function() {
  this.formElement.on("ajax:error", function() {
    alert('There was some issue with the product rating form. Please try again');
  });
};

$(document).ready(function(){
  var form = $('.rating-form'),
      ratingFormResponse = new HandleAjaxRequest(form);
  ratingFormResponse.init();
});
