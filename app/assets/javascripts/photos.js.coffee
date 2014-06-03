class Everyday.PhotosCarousel
  constructor: (@lightboxes) ->
    @currentIndex = 0
    @opened = false

    this.setupObservers()

  setupObservers: ->
    @lightboxes.each (index, lightbox) =>
      $(lightbox).on 'click', (l) =>
        @currentIndex = index

    Mousetrap.bind 'space', (e) => this.toggle(e)

    Mousetrap.bind 'right', (e) => this.right(e)
    Mousetrap.bind 'left',  (e) => this.left(e)

    Mousetrap.bind 'down', (e) => this.down(e)
    Mousetrap.bind 'up',   (e) => this.up(e)

  toggle: (e) ->
    if @opened
      sublime.lightbox(@lightboxes[@currentIndex]).close()
    else
      sublime.lightbox(@lightboxes[@currentIndex]).open()
    @opened = !@opened

    false

  right: (e) ->
    this.moveTo(1)

  left: (e) ->
    this.moveTo(-1)

  down: (e) ->
    this.moveTo(7)

  up: (e) ->
    this.moveTo(-7)

  moveTo: (step) ->
    @currentIndex = (@currentIndex + step) % @lightboxes.size()
    @currentIndex = @lightboxes.size() + @currentIndex if @currentIndex < 0
    this.toggle()
