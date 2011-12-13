require "acts_as_subscribable/subscribable_methods/instance_methods"

module ActsAsSubscribable
  module SubscribableMethods
    def acts_as_subscribable(options = {})
      options.reverse_merge! :subscriber => "User", :subscription => "Subscription"
      
      has_many :subscriptions, :class_name => options[:subscription].to_s, :dependent => :destroy
      has_many options[:subscriber].tableize, :class_name => options[:subscriber].to_s, :through => :subscriptions
      
      options[:subscriber].constantize.has_many :subscriptions, :class_name => options[:subscription].to_s, :dependent => :destroy
      options[:subscriber].constantize.has_many self.name.tableize.to_sym, :class_name => self.name, :through => :subscriptions
      
      options[:subscription].constantize.belongs_to options[:subscriber].downcase.to_sym
      options[:subscription].constantize.belongs_to self.name.downcase.to_sym
      
      send(:include, ActsAsSubscribable::SubscribableMethods::InstanceMethods)
      
      class_eval "def acts_as_subscribable_options; { :subscriber => '#{options[:subscriber]}', :subscription => '#{options[:subscription]}' }; end"
    end
end