module ActsAsSubscribable
  module SubscribableMethods
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