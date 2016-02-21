class VotesController < ApplicationController
  before_filter :load_votable
  before_filter :authenticate_user!

  def create
    @vote=@votable.votes.create(params_vote)
    redirect_to @path
  end

  def destroy
    vote=Vote.find(params[:id])
    type=vote[:votable_type]
    clazz=type.capitalize.constantize
    id=vote[:votable_id]
    if clazz==Question
      @pa=clazz.find(id)
    else
      ans=clazz.find(id)
      @pa=Question.find(ans.question_id)
    end
    vote.destroy
    redirect_to @pa
  end

  private

    def params_vote
      params.require(:vote).permit(:votable_type, :votable_id).merge(user: current_user)
    end

    def load_votable
      if params[:question_id]
        @votable = Question.find(params[:question_id])
        @path=@votable
      elsif params[:answer_id]
        @votable = Answer.find(params[:answer_id])
        @path= Question.find(@votable.question_id)
      end
    end
end
