#!/bin/env ruby
# encoding: utf-8
class Project < ActiveRecord::Base
  attr_accessible :name, :description, :start_date, :end_date, :owner_id

  has_many :tickets, :dependent => :destroy
  has_and_belongs_to_many :users

  # validates_presence_of :name
  # validates_presence_of :description
  
  # validates :name, :presence => true,
  #					:length => { :minimum => 5}
  # validates :description, :presence => true,
  #							:length => { :minimum => 5}
  
  # validates :name, :presence => true, :length => { :minimum => 5 }
  validates :name, presence: { :message => "Ett namn måste anges"}, :length => { :minimum => 5 }

  validates :description, :presence => true
end
