function SlideShow(data) {
  this.slideshowUl = data.slideshowUl;
  this.slideshowImages = data.slideshowImages;
  this.slideshowLength = this.slideshowImages.length;
  this.currentSlide = 0;
  this.fadeInSeconds = data.fadeInSeconds;
  this.fadeOutSeconds = data.fadeOutSeconds;
}

SlideShow.prototype.createSlideShow = function() {
  var _this = this;
  this.slideshowImages.eq(this.currentSlide).fadeIn(_this.fadeInSeconds).delay(_this.fadeOutSeconds).fadeOut(_this.fadeInSeconds, function() {
    _this.currentSlide < _this.slideshowLength - 1 ? _this.currentSlide++ : _this.currentSlide = 0;
    _this.createSlideShow();
  });
};

SlideShow.prototype.init = function() {
  this.slideshowImages.hide();
  this.createSlideShow();
};

$(document).ready(function(){
  var slideshow = $('div[data-slider="uploaded_image"]'),
      data = {
        slideshowUl: slideshow,
        slideshowImages: slideshow.children('img'),
        fadeInSeconds: 1000,
        fadeOutSeconds: 2000
      },
      slideshowObject = new SlideShow(data);
  slideshowObject.init();
});
