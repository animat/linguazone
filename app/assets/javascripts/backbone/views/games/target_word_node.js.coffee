Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.TargetWord extends Linguazone.Views.Games.NodeBaseView 
  game_type: "TargetWord",
  template: """
    <div class="question">
    <label>
      Target word
      <input type="text" value="<%= question %>">
    </label>
  </div>

  <div class="controls_wrapper">
    <a href="#" class="delete" tabIndex="-1">x</a>
  </div>
  """
