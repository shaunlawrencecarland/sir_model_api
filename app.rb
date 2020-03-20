require 'sinatra'
require "sinatra/reloader"
require "pry"
require_relative "model"

get '/v1/sir_model' do
    model = Model.new(
        eons: params["eons"].to_i,
        susceptible: params["susceptible"].to_i,
        infected: params["infected"].to_i,
        resistant: params["resistant"].to_i,
        rate_si: params["rate_si"].to_f,
        rate_ir: params["rate_ir"].to_f,
        population: params["population"].nil? ? nil : params["population"].to_i
    )

    content_type :json
    { results: model.results }.to_json
end


# ?eons=5&susceptible=10&infected=0&resistant=0&rate_si=0.01&rate_ir=0.05