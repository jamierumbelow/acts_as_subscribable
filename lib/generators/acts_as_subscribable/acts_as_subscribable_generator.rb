class ActsAsSubscribableGenerator < Rails::Generators::Base
  argument :subscription_name, :type => :string, :default => "Subscription"
  argument :subscriber_id, :type => :string, :default => "subscriber_id"
  argument :subscribed_id, :type => :string, :default => "subscribed_id"
  
  def generate_subscriptions
    generate "model #{subscription_name} #{subscriber_id}:integer #{subscribed_id}:integer"
  end
end
