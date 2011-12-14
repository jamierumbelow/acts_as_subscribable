require "acts_as_subscribable/subscribable_methods/instance_methods"

module ActsAsSubscribable
  module SubscribableMethods
    def acts_as_subscribable(options = {})
      options.reverse_merge! :subscriber => "User", :subscription => "Subscription", :subscriber_id => :subscriber_id, :subscribed_id => :subscribed_id
      
      options[:subscription] = options[:subscription].to_s
      options[:subscriber] = options[:subscriber].to_s
      
      subscriber_const = options[:subscriber].constantize
      subscriber_table = options[:subscriber].tableize
      subscription_const = options[:subscription].constantize
      
      has_many :subscriptions, :class_name => options[:subscription], :dependent => :destroy
      has_many subscriber_table, :class_name => options[:subscriber], :through => :subscriptions, :foreign_key => options[:subscriber_id]
      
      subscriber_const.has_many :subscriptions, :class_name => options[:subscription], :dependent => :destroy
      # subscriber_const.has_many self.name.tableize.to_sym, :class_name => self.name, :through => :subscriptions, :foreign_key => options[:subscribed_id]
      
      subscription_const.belongs_to options[:subscriber].downcase.to_sym
      subscription_const.belongs_to self.name.downcase.to_sym
      
      send(:include, ActsAsSubscribable::SubscribableMethods::InstanceMethods)
      
      class_eval "def acts_as_subscribable_options; { :subscriber => '#{options[:subscriber]}', :subscription => '#{options[:subscription]}' }; end"
    end
  end
end