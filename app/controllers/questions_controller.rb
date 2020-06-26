class QuestionsController < ApplicationController
  def create
    @question = current_user.questions(question_params)
    redirect_back(fallback_location: root_path) if @question.save
  end

  private

  def question_params
    params.require(:question).permit(:content, :post_id)
  end
end
