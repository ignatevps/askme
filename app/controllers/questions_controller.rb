class QuestionsController < ApplicationController
  before_action :set_question, only: %i[update destroy edit]
  before_action :authorize_user, except: [:create]

  def create
    @question = Question.new(question_params)
    
    if @question.save
      redirect_to user_path(@question.user), notice: 'New question created!'
    else
      render :edit
    end
  end

  def update
    @question.update(question_params)
    redirect_to user_path(@question.user), notice: "Question edited"
  end

  def destroy 
    @question.destroy
    redirect_to user_path, notice: "Question deleted"
  end

  def edit

  end

  private
  
  def set_question
    @question = Question.find(params[:id])
  end

  def authorize_user
    reject_user  unless @question.user == current_user
  end

  def question_params
    if current_user.present? && params[:question][:user_id].to_i == current_user.id
     params.require(:question).permit(:user_id, :body, :answer)
    else
     params.require(:question).permit(:user_id, :body)
    end
  end

end