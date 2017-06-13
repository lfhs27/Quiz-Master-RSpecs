require "rails_helper"

RSpec.describe QuizController, :type => :controller do
	describe "GET #index" do
		it "assigns a RANDOM question to @question" do
			question = Question.create!(:pregunta => "Number of vowels?", :respuesta => "5")
			get :index, id: question
			assigns(:question).should eq(question)
		end
		it "renders the :index template" do
			get :index, id: Question.create!(:pregunta => "Number of vowels?", :respuesta => "5")
			response.should render_template :index
		end
	end
	describe "POST #answer" do
		it "renders view" do
			post :answer, question_id: Question.create!(:pregunta => "Number of vowels?", :respuesta => "5"), respuesta: "5"
			response.should render_template :index
		end
		it "test for correct answer" do
			post :answer, question_id: Question.create!(:pregunta => "Number of vowels?", :respuesta => "5"), respuesta: "5"
			expect(flash[:correct]).to be(true)
		end
		it "test for incorrect answer" do
			post :answer, question_id: Question.create!(:pregunta => "Number of vowels?", :respuesta => "5"), respuesta: "7"
			expect(flash[:correct]).to be(false)
		end
	end
	describe "Convert into words" do
		it "convert numeric string into words" do
			controller.in_words("9").should == "nine"
		end
		it "do nothing with non numeric strings" do
			controller.in_words("nine").should == "nine"
		end
	end
end