Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.OneToOne extends Linguazone.Views.Games.NodeBaseView
  game_type: "OneToOne",
  template: """
  <div class="question">
    <input type="text" value="<%= question %>">
  </div>

  <div class="response">
    <input type="text" value="<%= response %>">
  </div>

  <div id="modal" style="display:none">
    <div class="upload"></div>
  </div>

  <div class="controls_wrapper">
    <a href="#" class="delete" tabIndex="-1"><img src="/images/customizer/remove_btn.png" alt="X" /></a>
  </div>
  <div class="clearFloat"></div>
  """
