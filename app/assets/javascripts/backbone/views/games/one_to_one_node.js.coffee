Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.OneToOne extends Linguazone.Views.Games.NodeBaseView
  template: """
  <div class="question lz_input tabs-bottom">
    <div id="question_1_text">
			<input type="text" value="<%= question %>">
		</div>
		<div id="question_1_image" class="lz_input_image">
			<input type="text" value="Search for an image" />
			<input type="submit" value="Search" />
		</div>
		<div id="question_1_audio" class="lz_input_audio">
			<p>audio recorder here</p>
		</div>
		<ul class="lz_input_toggle">
			<li><a href="#question_1_text">text</a></li>
			<li><a href="#question_1_image">image</a></li>
			<li><a href="#question_1_audio">audio</a></li>
		</ul>
   
  </div>

  <div class="response lz_input tabs-bottom">
    <div id="response_1_text">
      <input type="text" value="<%= response %>">
    </div>
    <ul class="lz_input_toggle">
			<li><a href="#question_1_text">text</a></li>
		</ul>
  </div>

  <div class="controls_wrapper">
    <a href="#" class="delete"><img src="/images/customizer/remove_btn.png" alt="X" /></a>
  </div>
  <br class="clearFloat" />
  """

