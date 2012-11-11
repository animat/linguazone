Linguazone.Views.Games ||= {}

class Linguazone.Views.Games.OneToOne extends Linguazone.Views.Games.NodeBaseView
  template: """
  <div class="question lz_input tabs-bottom">
    <div id="question_1_text">
			<input type="text" value="<%= question %>">
		</div>
		<div id="question_1_image" class="lz_input_image">
			<h3>Select an image</h3>
			<a>Browse LZ image gallery</a>
			<a>Search LZ and web</a>
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
    <a href="#" class="delete">x</a>
  </div>
  <br class="clearFloat" />
  """

