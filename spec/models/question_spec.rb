require "rails_helper"

RSpec.describe Question, :type => :model do
	quest = Question.new 
	it "Valid fields" do
		quest.pregunta = "number of vowels?"
		quest.respuesta = "5"
		expect(quest).to be_valid
	end
	it "pregunta too short" do
		quest.pregunta = "aaa"
		expect(quest).not_to be_valid
	end
	it "Missing pregunta" do
		quest.pregunta = nil
		expect(quest).not_to be_valid
	end
	it "Missing respuesta" do
		quest.respuesta = nil
		expect(quest).not_to be_valid
	end
end