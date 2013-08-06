
class ClassPicker
  constructor: (@root, @options) ->
    @root_node    = $(".#{root}").first()
    @dates_node   = $(".#{root} > .dates").first()
    @times_node   = $(".#{root} > .times").first()
    @classes_node = $(".#{root} > .classes").first()
    @date_selected = "none"
    @time_selected = "none"
    @class_selected = "none"

  initialize: ->
    @state = "dates"
    this.render()

  render: ->
    # set visability
    for node in @root_node.children(".step")
      if $(node).hasClass(@state)
        $(node).show()
      else
        $(node).hide()

    switch @state
      when "dates" then this.renderDates()
      when "times" then this.renderTimes()
      when "classes" then this.renderClasses()
      when "completed" then this.renderCompleted()

    this.updateSelections()


  renderDates: ->
    for day in @options.days
      new_node = $("<a href='#'><div class='date'>#{day.date}</div></a>")
      new_node.data("choice", day.date)
      @dates_node.append(new_node)

    @dates_node.find("a").click (e) =>
      @state = "times"
      @date_selected = $(e.currentTarget).data('choice')
      e.preventDefault()
      this.render()


  renderTimes: ->
    for opt in @options.days[0].times
      new_node = $("<a href='#'><div class='time'>#{opt.time}</div></a>")
      new_node.data("choice", opt.time)
      @times_node.append(new_node)

    @times_node.find("a").click (e) =>
      @state = "classes"
      @time_selected = $(e.currentTarget).data('choice')
      e.preventDefault()
      this.render()

  renderClasses: ->
    for klass in @options.days[0].times[0].classes
      new_node = $("<a href='#'><div class='class'>#{klass.instructor}</div></a>")
      new_node.data("choice", klass.instructor)
      @classes_node.append(new_node)

    @classes_node.find("a").click (e) =>
      @state = "completed"
      @class_selected = $(e.currentTarget).data('choice')
      e.preventDefault()
      this.render()

  renderCompleted: ->
    # this is where you would put the confirmation screen/buttons etc..


  updateSelections: ->
    @root_node.find("#date-selected").first().text(this.dateSelected())
    @root_node.find("#time-selected").first().text(this.timeSelected())
    @root_node.find("#class-selected").first().text(this.classSelected())



  remove_handlers: (parent_node) ->
    # $(parent_node).find("a").unbind 'click'


  dateSelected: ->
    @date_selected

  timeSelected: ->
    @time_selected

  classSelected: ->
    @class_selected





$(document).ready ->
  class1 = new ClassPicker("class1", schedule)
  class1.initialize()

  class1 = new ClassPicker("class2", schedule)
  class1.initialize()




    # for node in @root_node.children()
    #   if $(node).hasClass(@state)
    #     @attach_handlers(node)
    #     $(node).show()
    #   else
    #     @remove_handlers(node)
    #     $(node).hide()
