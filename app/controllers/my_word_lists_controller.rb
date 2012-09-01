class MyWordListsController < CourseItemsController
  before_filter :check_expired
  
  def index
    @search = AvailableWordList.search(params[:search])
    
    @word_lists = AvailableWordList.includes(:word_list).where(:user_id => current_user.id, :course_id => 0).order("word_lists.updated_at DESC").page(params[:page])
    @total_word_lists_count = AvailableWordList.where(:user_id => current_user.id, :course_id => 0).length
  end
  
  def show
    @word_list = WordList.find(params[:id])
  end
  
  def destroy
    @word_list = WordList.find(params[:id])
    if @word_list.updated_by_id == current_user.id
      @available_listings = AvailableWordList.all(:conditions => ["word_list_id = ?", params[:id]])
      @available_listings.each do |al|
        al.destroy
      end
      
      @linked_to_games = GamesWordList.all(:conditions => ["word_list_id = ?", params[:id]])
      unless @linked_to_games.nil?
        @linked_to_games.each do |lg|
          lg.destroy
        end
      end
      
      @word_list.destroy
    
      flash[:notice] = "The word list has been deleted."
      redirect_to my_word_lists_path
    else
      flash[:error] = "You do not have access to that word list."
      redirect_to my_word_lists_path
    end
  end
  
  def import
    @word_list = WordList.new
  end
  
  def confirm_spreadsheet_import
    if params[:word_list][:spreadsheet].original_filename.include? ".xls"  
      tmp = params[:word_list][:spreadsheet].tempfile
      book = Spreadsheet.open tmp
      sheet1 = book.worksheet 0
      @gamedata = ["<gamedata>"]
      @errors = Hash.new
      @counter = 0
    
      sheet1.each 0 do |row|
        @english = row[0]
        @lang = row[1]
      
        if @english.blank? or @lang.blank? # TODO: Is there a better way to validate this string?
          @errors["#{@counter+1}"] = "There was a blank value at row ##{@counter+1}"
        else
          node = '<node><question name="english" type="text" content="'+@english+'" /><response name="lang" type="text" content="'+@lang+'" /></node>'
          @gamedata << node
        end
        @counter+=1
      end
      @gamedata << "</gamedata>"
    
      if @errors.empty?
        doc = REXML::Document.new(@gamedata.to_s)
        @nodes = REXML::XPath.match(doc, "//node")
      else
        # render the import page with an error
        flash[:error] = "We're sorry: there was an error importing your data. Please confirm that it has been formatted correctly."
        redirect_to import_my_word_lists_path and return
      end
    
      @word_list = WordList.new(:xml => @gamedata, :language_id => params[:word_list][:language_id], 
                                  :description => params[:word_list][:description])
    else
      flash[:error] = "Please confirm that you are uploading an Excel Spreadsheet (.xls) and try again."
      redirect_to import_my_word_lists_path and return
    end
  end
  
  def create_by_spreadsheet
    @word_list = WordList.new(params[:word_list])
    @word_list.created_at = Time.now
    @word_list.updated_at = Time.now
    @word_list.created_by_id = current_user.id
    @word_list.updated_by_id = current_user.id
    if @word_list.save
      flash[:success] = "Your word list has been imported and saved. Please make any changes then add it to your class pages."
      redirect_to :controller => "customize", :action => "edit", :cmzr_type => "list", :id => @word_list.id
    else
      flash[:error] = "Oops! There was a problem importing your word list."
      redirect_to import_my_word_lists_path
    end
  end
  
  def joining_table
    AvailableWordList
  end
  
end
