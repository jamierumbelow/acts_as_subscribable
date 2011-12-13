require "acts_as_subscribable/version"

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
    
    module InstanceMethods
      def subscribers
        send acts_as_subscribable_options[:subscriber].tableize
      end
      
      def subscribe(subscriber)
        send(acts_as_subscribable_options[:subscriber].tableize).send(:<<, subscriber) unless subscribed?(subscriber)
      end
      
      def unsubscribe(subscriber)
        subscriber.subscriptions.where(:todo_id => id).delete_all
      end
      
      def subscribed?(subscriber)
        !subscriptions.where(:user_id => subscriber.id).empty?
      end
    end
  end
end

ActiveRecord::Base.extend ActsAsSubscribable::SubscribableMethods