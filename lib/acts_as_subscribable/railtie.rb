module ActsAsSubscribable
  class Railtie < Rails::Railtie
    initializer 'acts_as_subscribable.subscribable_methods' do
      ActiveSupport.on_load :active_record do
        extend SubscribableMethods
      end
    end
  end
end