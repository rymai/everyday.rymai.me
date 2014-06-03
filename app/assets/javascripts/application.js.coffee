#= require jquery
#= require jquery_ujs
#= require mousetrap.min.js
#= require_self
#= require_tree .

$.fn.exists = -> @length > 0

window.Everyday = {}

$(document).ready ->
  window.photosCarousel = new Everyday.PhotosCarousel($('a.sublime'))
