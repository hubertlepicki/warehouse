require 'spec_helper'

class Users < Repository
  def initialize(options = {})
    super
  end
end

class User
  attr_accessor :name
end

describe Users do
  it 'should raise Repository::ModelClassRequiredException if no model_class option was provided' do
    -> { Users.new }.should raise_error(Repository::ModelClassRequiredException)
  end

  context 'simple fetching and getting objects from memory' do
    let(:repo) { Users.new(model_class: User) }

    it 'should return no objects when repo is empty' do
      repo.fetch_all.should be_empty
    end

    it 'should return previously stored object' do
      u = User.new.tap { name = 'John' }
      repo.store(u)
      repo.fetch_all.should include(u)
    end

    it 'should not store the object multiple times in the same repo' do
      u = User.new.tap { name = 'John' }
      repo.store(u)
      repo.store(u)
      repo.fetch_all.count.should == 1
    end
  end

  context 'filtering results with query object' do
    let(:repo) { Users.new(model_class: User,
                           query_object: ->(repo) { repo.collection.select {|e| e == repo.collection.first} })
                           # return only first object from collection
    }

    it 'should return only object matched by query' do
      u1 = User.new.tap { name = 'John' }
      u2 = User.new.tap { name = 'Jack' }
      repo.store(u1)
      repo.store(u2)
      repo.fetch_all.count.should == 1
    end
  end
end
