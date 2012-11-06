Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.OneToOne extends Linguazone.Views.Games.NodeBaseView
  template: """
  <div class="question">
    <label>
      Your Input
      <input type="text" value="<%= question %>">
    </label>
  </div>

  <div class="response">
    <label>
      Student Answer
      <input type="text" value="<%= response %>">
    </label>
  </div>

  <div class="delete_wrapper" style="float:right; padding-right:50px;">
    <a href="#" class="delete">x</a>
  </div>
  """

