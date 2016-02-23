class AnswersController < ApplicationController
  def create
    question= Question.find(params[:question_id])
    answer=question.answers.new(answer_params)
    # redirect_to question
    respond_to do |format|
      if answer.save
        format.html { redirect_to question, notice: 'Respuesta creada' }
        format.json { render :show, status: :created, location: question }
      else
        format.html { redirect_to question, alert: 'La respuesta no puede estar vacia' }
        format.json { render json: answer.errors, status: :unprocessable_entity }
      end
    end
  end

private
  def answer_params
    params.require(:answer).permit(:body).merge(user: current_user)
  end
end
