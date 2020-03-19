require "spec_helper"

describe Model do
    describe "#results" do
    let(:model) do
        described_class.new(
            eons: eons,
            infected: 1,
            susceptible: 1,
            resistant: 1,
            rate_si: 0.01,
            rate_ir: 0.05
        )
    end

        context "when the eons is zero" do
            let(:eons) { 0 }

            it "returns 1 for the infected, susceptible, and resistant fields" do
                expect(model.results).to eq([ { eon: 0, infected: 1, susceptible: 1, resistant: 1 } ])
            end
        end

        context "when the eons is less than 0" do
            let(:eons) { -1 }

            it "raises an error" do
                expect { model.results }.to raise_error
            end
        end
    end
end
