require "column_info_reset/version"

module ColumnInfoReset
  def self.included(base)
    base.extend ClassMethods
    base.class_eval do
      class << self
        alias_method :transaction_without_column_info_reset, :transaction
        alias_method :transaction, :transaction_with_column_info_reset
      end
    end
  end

  module ClassMethods
    def transaction_with_column_info_reset(*objects, &block)
      begin
        transaction_without_column_info_reset(*objects, &block)
      rescue ActiveRecord::StatementInvalid => e
        if e.message =~ /Unknown column '.*' in 'field list'/
          logger.info "Retrying with column information reset"
          reset_column_information
          transaction_without_column_info_reset(*objects, &block)
        else
          raise e
        end
      end
    end
  end
end

require 'active_record'
ActiveRecord::Base.send :include, ColumnInfoReset
