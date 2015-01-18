class Linguazone.Views.Activity extends Backbone.Marionette.ItemView
  className: "activity-wrapper"
  template: """
      <h4 id="step1_title">Step 1: Select a Game</h4>

      <div class="activity">
        <div class="circle_icon" style="background: url('<%= backgroundIcon() %>') no-repeat center;"></div>

        <h2><%= name %></h2>

        <div class="icons">
          <%= help %>
          <div class="video-link">
            <a class="venobox" data-type="youtube" href="<%= video_link %>"><i class="fa fa-play"></i></a>
          </div>
        </div>

        <div class="activity_details">
          <p><%= description %></p>
        </div>
      </div>
  """
  templateHelpers: =>
    backgroundIcon: =>
      name = @model.get("name").toLowerCase()
      console.debug @model.get("name")
      console.debug "*******************************************************"
      "http://www.linguazone.com/games/#{name}/display/icon.jpg"
  onRender: ->
    console.log "object", 'wat'
