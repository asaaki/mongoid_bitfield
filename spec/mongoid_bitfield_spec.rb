require "spec_helper"

class TestDoc
  include Mongoid::Document
  include Mongoid::Bitfield

  bitfield :flags, :is_admin, :adult, :drinker
end

describe Mongoid::Bitfield do
  let(:doc) { TestDoc.new }

  it ".bitfield sets a mongoid_field with provided name" do
    expect(doc).to respond_to(:flags)
    expect(doc).to respond_to(:flags=)
  end

  it ".bitfield sets getters and setters for each provided bit" do
    [:is_admin, :adult, :drinker].each do |bit|
      expect(doc).to respond_to(bit)
      expect(doc).to respond_to(:"#{bit}=")
    end
  end

  context "setting and getting bits" do
    it "sets a single bit correctly" do
      doc.is_admin = true
      expect(doc.flags).to eq(1) # is_admin is first bit => 1
    end

    it "sets multiple bits correctly" do
      doc.is_admin = true
      doc.drinker  = true
      expect(doc.flags).to eq(1 + 4) # is_admin = 1, drinker = 4
    end

    it "gets a single bit" do
      doc.adult = true
      expect(doc.is_admin).to be(false)
      expect(doc.drinker).to  be(false)
      expect(doc.adult).to    be(true)
    end
  end

  context "enabler and disabler" do
    it "enables a flag and save this state (atomically!)" do
      td = TestDoc.create!(flags: 0)
      td.is_admin_enable!

      expect(TestDoc.first.is_admin).to be(true)
    end

    it "disables a flag and save this state (atomically!)" do
      td = TestDoc.create!(flags: (1 + 2 + 4)) # all flags enabled
      td.drinker_disable!

      expect(TestDoc.first.drinker).to be(false)
    end
  end
end
