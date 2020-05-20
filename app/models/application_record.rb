# frozen_string_literal: true

# ApplicationRecord class
class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # Instance method for extend insert_all for nested models
  def method_missing(method, data)
    return super method, data unless method.to_s =~ /^upsert_all\w+/
    self.class.send(:define_method, method) do
      nested_model = method.to_s.gsub(/^upsert_all_/, '')
                           .singularize.camelize.constantize
      # args[0].map { |x| x[self.class.to_s.downcase + '_id'] = id }
      # nested_model.upsert_all(args[0], unique_by: %i[slug], returning: %w[id])
    end
    self.send(method, data)
  end
end
