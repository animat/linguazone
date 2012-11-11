Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.TargetWord extends Linguazone.Views.Games.NodeBaseView 
  template: """
    <div class="response">
    <label>
      Target word
      <input type="text" value="<%= response %>">
    </label>
  </div>

  <div class="controls_wrapper">
    <a href="#" class="delete">x</a>
  </div>
  """
