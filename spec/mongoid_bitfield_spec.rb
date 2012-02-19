# encoding: utf-8
require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

class TestDoc
  include Mongoid::Document
  include Mongoid::Bitfield

  bitfield :flags, :is_admin, :adult, :drinker
end

describe Mongoid::Bitfield do

  let(:doc) { TestDoc.new }

  it ".bitfield sets a mongoid_field with provided name" do
    doc.should respond_to(:flags)
    doc.should respond_to(:flags=)
  end

  it ".bitfield sets getters and setters for each provided bit" do
    [:is_admin, :adult, :drinker].each do |bit|
      doc.should respond_to(bit)
      doc.should respond_to(:"#{bit}=")
    end
  end

  context "setting and getting bits" do
    it "sets a single bit correctly" do
      doc.is_admin = true
      doc.flags.should == 1 # is_admin is first bit => 1
    end

    it "sets multiple bits correctly" do
      doc.is_admin = true
      doc.drinker  = true
      doc.flags.should == (1 + 4) # is_admin = 1, drinker = 4
    end

    it "gets a single bit" do
      doc.adult = true
      doc.is_admin.should be_false
      doc.drinker.should  be_false
      doc.adult.should    be_true
    end
  end

  context "enabler and disabler" do
    before do
      TestDoc.destroy_all
    end

    it "enables a flag and save this state (atomically!)" do
      td = TestDoc.create!(:flags => 0)
      td.is_admin_enable!

      TestDoc.first.is_admin.should be_true
    end

    it "disables a flag and save this state (atomically!)" do
      td = TestDoc.create!(:flags => (1+2+4)) # all flags enabled
      td.drinker_disable!

      TestDoc.first.drinker.should be_false
    end
  end

end