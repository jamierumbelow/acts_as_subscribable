require "acts_as_subscribable/version"
require "acts_as_subscribable/subscribable_methods"

module ActsAsSubscribable
end

ActiveRecord::Base.extend ActsAsSubscribable::SubscribableMethods