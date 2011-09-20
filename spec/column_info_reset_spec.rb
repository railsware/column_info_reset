require 'column_info_reset'
require 'logger'

begin
  require 'mysql2'
rescue LoadError
end

begin
  require 'mysql'
rescue LoadError
end

class ColumnInfoResetUser < ActiveRecord::Base
end

describe "Record Creation" do
  before(:each) do
    ActiveRecord::Base.establish_connection({
      :database => "test",
      :adapter  => defined?(Mysql2) ? "mysql2" : "mysql",
      :host     => "localhost",
      :username => "root",
      :password => nil,
      :encoding => "utf8",
    })
    ActiveRecord::Base.logger = Logger.new('active_record.log')

    File.read('db/structure.sql').strip.split("\n\n").each do |statement|
      ActiveRecord::Base.connection.execute(statement)
    end
  end

  it "shoud create record as usual" do
    ColumnInfoResetUser.column_names.sort.should == [
      "country", "created_at", "email", "id", "state", "updated_at"
    ]

    lambda {
      ColumnInfoResetUser.create!(:email => 'alice@mirror.com')
    }.should_not raise_error

    record = ColumnInfoResetUser.find :first
    record.email.should == 'alice@mirror.com'
    record.should respond_to(:country)
  end

  context "when column does not exist in database" do
    it "shoud retry transaction and create record without column" do
      ColumnInfoResetUser.column_names.sort.should == [
        "country", "created_at", "email", "id", "state", "updated_at"
      ]

      ActiveRecord::Base.connection.remove_column(ColumnInfoResetUser.table_name, "country")

      ColumnInfoResetUser.column_names.sort.should == [
        "country", "created_at", "email", "id", "state", "updated_at"
      ]

      lambda {
        ColumnInfoResetUser.create!(:email => 'alice@mirror.com')
      }.should_not raise_error

      record = ColumnInfoResetUser.find :first
      record.email.should == 'alice@mirror.com'
      record.should_not respond_to(:country)

      ColumnInfoResetUser.column_names.sort.should == [
        "created_at", "email", "id", "state", "updated_at"
      ]
    end
  end
end

