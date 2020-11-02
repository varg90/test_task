require 'rails_helper'

describe BitcoinService do
  subject { described_class.new }

  before do
    allow_any_instance_of(BitcoinService).to receive(:get_api_response_data).and_return []
  end

  context 'yearly' do
    it 'should return proper data' do
      expect(subject.data_for_period(:year).size).to eq 12
    end
  end

  context 'monthly' do
    it 'should return proper data' do
      expect(subject.data_for_period(:month).size).to eq 30
    end
  end

  context 'weekly' do
    it 'should return proper data' do
      expect(subject.data_for_period(:week).size).to eq 7
    end
  end

  context 'daily' do
    it 'should return proper data' do
      expect(subject.data_for_period(:day).size).to eq 24
    end
  end

  context 'hourly' do
    it 'should return proper data' do
      expect(subject.data_for_period(:hour).size).to eq 60
    end
  end
end
