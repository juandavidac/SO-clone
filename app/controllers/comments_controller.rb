class CommentsController < ApplicationController
  before_filter :load_commentable
  def create
    # clazz=params[:comment][:commentable_type].capitalize.constantize
    # question_or_answer= clazz.find(params[:comment][:commentable_id])
    # question_or_answer.comments.create(params_comment)
    # redirect_to root_path
    @comment=@commentable.comments.create(params_comment)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to @path, notice: 'Comentario creado' }
        format.json { render :show, status: :created, location: question }
      else
        format.html { redirect_to @path, alert: 'El comentario no puede estar vacio' }
        format.json { render json: answer.errors, status: :unprocessable_entity }
      end
    end
  end

  private

    def params_comment
      params.require(:comment).permit(:content).merge(user: current_user)
    end

    def load_commentable
      if params[:question_id]
        @commentable = Question.find(params[:question_id])
        @path=@commentable
      elsif params[:answer_id]
        @commentable = Answer.find(params[:answer_id])
        @path= Question.find(@commentable.question_id)
        # qid=@commentable[answer_id]
        # @path=Question.find(qid)
      end
    end
end
