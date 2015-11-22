class Admin::WordsController < Admin::BaseController
  require "csv"
  require "rails/all"
  before_action :verify_admin
  before_action :current_word, only: [:edit, :update]
  
  def index
  end

  def create
    if params[:file].nil? && !params[:check_action].nil?
      respond_to do |format|
        format.html 
        format.csv {send_data export}
      end
    else
      import params[:file]
    end
  end

  def edit    
  end

  def update
    @word.update_attributes word_params
    flash[:success] = t "admin.words.update.flash_success"
    redirect_to [:edit, :admin, @word]
  end

  private
  def import file
    count = 0
    begin
      CSV.foreach file.path, headers: true do |f|
        item_hash = f.to_hash
        if csv_file? item_hash
          category = Category.find_or_create_by name: item_hash["category_name"]
          if Word.find_by(content: item_hash["word_content"]).nil?
            count = create_word(item_hash["word_content"],
              item_hash["true_answer"], item_hash["other_answers"], category.id, count)
          end
        end
      end
      check_update count
      redirect_to categories_path
    rescue Exception
      error
    end
  end

  def export
    column_name = Settings.word.column_name
    CSV.generate(headers: true) do |csv|
      csv << column_name
      Category.all.each do |category|
        category.words.each do |word|
          true_answer = ""
          other_answers = ""
          word.answers.each do |answer|
            if answer.is_correct?
              true_answer << answer.content
            else
              other_answers << answer.content
              other_answers << "/"
            end
          end
          csv << [category.name, word.content, true_answer, other_answers]
        end
      end
    end
  end

  def csv_file? item_hash
    !(item_hash["category_name"].nil? &&
      item_hash["word_content"].nil? &&
      item_hash["true_answer"].nil? &&
      item_hash["other_answers"].nil?)
  end

  def check_update count
    if count == 0
      flash[:danger] = t("admin.words.index.flash_danger1").join(" ")
    else
      flash[:success] = t "admin.words.index.flash_success"
    end
  end

  def error
    flash[:danger] = t "admin.words.index.flash_danger2"
    redirect_to categories_path
  end

  def create_word word_content, true_answer, other_answers, id, count
    word = Word.create content: word_content, category_id: id
    Answer.create content: true_answer, word_id: word.id, is_correct: true
    other_answers.to_s.split("/").each do |ans|
      Answer.create content: ans, word_id: word.id, is_correct: false unless ans.nil?
    end
    count += 1
  end

  def word_params
    params.require(:word)
      .permit :content, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def current_word
    @word = Word.find params[:id]
  end
end
