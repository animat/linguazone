class Linguazone.Views.Activity extends Backbone.Marionette.ItemView
  className: "activity-wrapper"
  template: """
      <h4 id="step1_title">Step 1: Select a game</h4>

      <div class="selected_activity">
        <div class="circle_icon">
          <img src="<%= backgroundIcon() %>" />
          <div class="video-link">
            <a class="venobox" data-type="youtube" href="<%= video_link %>">View demo <i class="fa fa-play-circle-o"></i></a>
          </div>
        </div>

        <div class="activity_info">
          <div><h2><%= name %></h2> <%= changeGameButton() %></div>

          <div class="activity_details">
            <p><%= description %></p>
          </div>
        </div>
      </div>
  """
  templateHelpers: =>
    backgroundIcon: =>
      name = @model.get("swf")
      "http://www.linguazone.com/games/#{name}/display/icon.jpg"
    changeGameButton: =>
      # TODO @Len: How would I implement a button reset the user back to step 1?
      # TODO: only make this button available when a user is creating, not editing, a game
      "<button><i class='fa fa-undo'></i> change game</button>"
