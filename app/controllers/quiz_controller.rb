class QuizController < ApplicationController
	layout 'dashboard'
	def index
		@question = Question.order("RANDOM()").first
	end
	
	def answer
		@question = Question.find(params[:question_id])
		@answer = in_words(@question.respuesta.downcase.strip)
		@user_answer = in_words(params[:respuesta].downcase.strip)
		flash[:correct] = @answer == @user_answer
		
		render 'index'
	end
	
	def in_words(str)
		if str.numeric?
			begin
				Integer(str).humanize
			rescue
				Float(str).humanize
			end
		else
			str
		end
	end
end