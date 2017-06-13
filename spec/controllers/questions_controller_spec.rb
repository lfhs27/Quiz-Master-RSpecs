require "rails_helper"

RSpec.describe QuestionsController, :type => :controller do
	describe "GET #index" do
		it "populates an array of questions" do
			question = Question.create!(:pregunta => "Number of vowels?", :respuesta => "5")
			get :index
			assigns(:questions).should eq([question])
		end
		it "renders the :index view" do
			get :index
			response.should render_template :index
		end
	end
  
	describe "GET #show" do
		it "assigns the requested question to @question" do
			question = Question.create!(:pregunta => "Number of vowels?", :respuesta => "5")
			get :show, id: question
			assigns(:question).should eq(question)
		end
		it "renders the :show template" do
			get :show, id: Question.create!(:pregunta => "Number of vowels?", :respuesta => "5")
			response.should render_template :show
		end
	end
  
	describe "GET #new" do
		it "renders the :new template" do		
			get :new
			response.should render_template :new
		end
	end
  
	describe "POST #create" do
		context "with valid attributes" do
			it "saves the new question in the database" do
				expect{
					post :create, question:  {"pregunta" => "Number of vowels?", "respuesta" => "5"} 
				}.to change(Question, :count).by(1)
			end
			it "redirects to the :index view" do
				post :create, question: {"pregunta" => "Number of vowelss?", "respuesta" => "8"} 
				response.should redirect_to :action => :index
			end
		end
    
		context "with invalid question (nil)" do
			it "does not save the new question in the database" do
				expect{
					post :create, question: {"pregunta" => nil, "respuesta" => "5"}
				}.to_not change(Question,:count)
			end
			it "re-renders the :new template" do
				post :create, question: {"pregunta" => nil, "respuesta" => "5"}
				response.should render_template :new
			end
		end
    
		context "with invalid question (too short)" do
			it "does not save the new question in the database" do
				expect{
					post :create, question: {"pregunta" => "a", "respuesta" => "5"}
				}.to_not change(Question,:count)
			end
			it "re-renders the :new template" do
				post :create, question: {"pregunta" => "a", "respuesta" => "5"}
				response.should render_template :new
			end
		end
    
		context "with invalid answer" do
			it "does not save the new question in the database" do
				expect{
					post :create, question: {"pregunta" => "Number of vowels?", "respuesta" => nil}
				}.to_not change(Question,:count)
			end
			it "re-renders the :new template" do
				post :create, question: {"pregunta" => "Number of vowels?", "respuesta" => nil}
				response.should render_template :new
			end
		end
	end
	
	describe 'PUT update' do
		before :each do
			@question = Question.create!(:pregunta => "Number of vowels?", :respuesta => "5")
		end
  
		context "valid attributes" do
			it "located the requested @question" do
				put :update, id: @question, question: {"pregunta" => "Number of vowels?", "respuesta" => "5"} 
				assigns(:question).should eq(@question)      
			end
  
			it "changes @question's attributes" do
				put :update, id: @question, 
				question: {"pregunta" => "Number of vowels?", "respuesta" => "5"} 
				@question.reload
				@question.pregunta.should eq("Number of vowels?")
				@question.respuesta.should eq("5")
			end
  
			it "redirects to the updated question" do
				put :update, id: @question, question: {"pregunta" => "Number of vowels?", "respuesta" => "5"} 
				response.should redirect_to :action => :index
			end
		end
  
		context "invalid question (nil)" do
			it "locates the requested @question" do
				put :update, id: @question, question: {"pregunta" => nil, "respuesta" => "5"} 
				assigns(:question).should eq(@question)      
			end
		
			it "does not change @question's attributes" do
				put :update, id: @question, 
				question: {"pregunta" => nil, "respuesta" => "5"} 
				@question.reload
				@question.pregunta.should_not eq(nil)
				@question.respuesta.should eq("5")
			end
		
			it "re-renders the edit method" do
				put :update, id: @question, question: {"pregunta" => nil, "respuesta" => "5"} 
				response.should render_template :edit
			end
		end
  
		context "invalid question (too short)" do
			it "locates the requested @question" do
				put :update, id: @question, question: {"pregunta" => "a", "respuesta" => "5"} 
				assigns(:question).should eq(@question)      
			end
		
			it "does not change @question's attributes" do
				put :update, id: @question, 
				question: {"pregunta" => "a", "respuesta" => "5"} 
				@question.reload
				@question.pregunta.should_not eq("a")
				@question.respuesta.should eq("5")
			end
		
			it "re-renders the edit method" do
				put :update, id: @question, question: {"pregunta" => "a", "respuesta" => "5"} 
				response.should render_template :edit
			end
		end
  
		context "invalid answer" do
			it "locates the requested @question" do
				put :update, id: @question, question: {"pregunta" => "Number of vowels?", "respuesta" => nil} 
				assigns(:question).should eq(@question)      
			end
		
			it "does not change @question's attributes" do
				put :update, id: @question, 
				question: {"pregunta" => "Number of vowels?", "respuesta" => nil} 
				@question.reload
				@question.pregunta.should eq("Number of vowels?")
				@question.respuesta.should_not eq(nil)
			end
		
			it "re-renders the edit method" do
				put :update, id: @question, question: {"pregunta" => "Number of vowels?", "respuesta" => nil} 
				response.should render_template :edit
			end
		end
	end
	
	describe 'DELETE destroy' do
		before :each do
			@question = Question.create!(:pregunta => "Number of vowels?", :respuesta => "5")
		end
  
		it "deletes question" do
			expect{
				delete :destroy, id: @question        
			}.to change(Question,:count).by(-1)
		end
    
		it "redirects to question#index" do
			delete :destroy, id: @question
			response.should redirect_to questions_url
		end
	end
end