Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.OneToOne extends Linguazone.Views.Games.NodeBaseView
  game_type: "OneToOne",
  template: """
  <div class="question lz_input tabs-bottom">
    <div id="question_1_text">
      <input name="question" class="question-input" type="text" value="<%= question %>">
    </div>
    <div id="question_1_image" class="lz_input_image">
      <input type="text" value="Search for an image" />
      <input type="submit" value="Search" />
    </div>
    <div id="question_1_audio" class="lz_input_audio">
      <p>audio recorder here</p>
    </div>

    <ul class="lz_input_toggle">
      <li><a href="#question_1_text" tabIndex="-1">text</a></li>
      <li><a href="#question_1_image" tabIndex="-1">image</a></li>
      <li><a href="#question_1_audio" tabIndex="-1">audio</a></li>
    </ul>

  </div>

  <div class="response lz_input tabs-bottom">
    <div id="response_1_text">
      <input name="response" type="text" value="<%= response %>">
    </div>
    <ul class="lz_input_toggle">
      <li><a href="#question_1_text" tabIndex="-1">text</a></li>
    </ul>
  </div>

  <div class="controls_wrapper">
    <a href="#" class="delete" tabIndex="-1"><img src="/images/customizer/remove_btn.png" alt="X" /></a>
  </div>
  <br class="clearFloat" />
  """

