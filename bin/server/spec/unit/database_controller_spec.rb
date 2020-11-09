# frozen_string_literal: true

require 'rspec'
require_relative '../spec_helper'
require_relative '../../modules/database_controller'
require_relative '../../db/seeder'

# Temp class
class Temp < DatabaseController
  set_columns :username, :password, :email, :registerTime, :id
  set_table :users
end

# rubocop:disable Metrics/BlockLength
RSpec.describe 'DatabaseController:' do
  context 'When testing the DatabaseClass' do
    before(:all) do
      Seeder.seed!
    end

    it 'the controller should be able to fetch a sequel dataset' do
      expect(Temp.fetch_dataset.class).to eq Sequel::SQLite::Dataset
    end

    it 'the controller should be able to insert data to the database' do
      temp = Temp.new({ username: 'username', password: '#!"#&(YSAJDHY/DT', email: 'email', registerTime: 0o000000 })
      temp.save
      expect(temp.id).to eq 1
    end

    it 'the controller should be able to get all data from a the database' do
      expect(Temp.fetch_all.first.instance_variables).to eq %i[@username @password @email @registerTime @id @status]
      expect(Temp.fetch_all.first.username).to eq 'username'
      expect(Temp.fetch_all.length).to eq 1
    end

    it 'the controller should be able to get selected data from a the database' do
      expect(Temp.fetch_where(id: 1).instance_variables).to eq []
      expect(Temp.fetch_where(id: 2)).to eq []
    end

    it 'the controller should be able to get update data in the database' do
      temp = Temp.fetch_where(id: 1)
      temp.first.username = 'another username or something'
      temp.first.save
      expect(Temp.fetch_where(id: 1).first.instance_variables).to eq %i[@username @password @email
                                                                        @registerTime @id @status]
      expect(Temp.fetch_where(id: 1).first.username).to eq 'another username or something'
      expect(Temp.fetch_where(id: 2)).to eq []
    end

    it 'the controller should be able to handle multiple rows' do
      temp = Temp.new({ username: 'username', password: '#!"#&(YSAJDHY/DT', email: 'email', registerTime: 0o000000 })
      temp.save
      expect(Temp.fetch_where(id: 2).first.instance_variables).to eq %i[@username @password @email
                                                                        @registerTime @id @status]
      expect(Temp.fetch_all.length).to eq 2
    end

    it 'the controller should be able to delete a databse entry' do
      temp = Temp.fetch_where(id: 2)
      expect(temp.first.class).to eq Temp
      temp.first.delete
      expect(Temp.fetch_where(id: 2)).to eq []
    end
  end
  # rubocop:enable Metrics/BlockLength
end
