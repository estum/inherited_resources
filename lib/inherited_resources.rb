# This is here because responders don't require it.
require 'rails/engine'
require 'responders'
require 'inherited_resources/engine'
require 'inherited_resources/blank_slate'
require 'inherited_resources/responder'

module InheritedResources
  ACTIONS = [ :index, :show, :new, :edit, :create, :update, :destroy ] unless self.const_defined?(:ACTIONS)

  autoload :Actions,            'inherited_resources/actions'
  autoload :BaseHelpers,        'inherited_resources/base_helpers'
  autoload :ShallowHelpers,     'inherited_resources/shallow_helpers'
  autoload :BelongsToHelpers,   'inherited_resources/belongs_to_helpers'
  autoload :ClassMethods,       'inherited_resources/class_methods'
  autoload :DSL,                'inherited_resources/dsl'
  autoload :PolymorphicHelpers, 'inherited_resources/polymorphic_helpers'
  autoload :SingletonHelpers,   'inherited_resources/singleton_helpers'
  autoload :UrlHelpers,         'inherited_resources/url_helpers'
  autoload :VERSION,            'inherited_resources/version'

  # Change the flash keys used by FlashResponder.
  def self.flash_keys=(array)
    Responders::FlashResponder.flash_keys = array
  end
end

ActiveSupport.on_load(:action_controller) do
  # We can remove this check and change to `on_load(:action_controller_base)` in Rails 5.2.
  if self == ActionController::Base
    # If you cannot inherit from InheritedResources::Base you can call
    # inherit_resources in your controller to have all the required modules and
    # funcionality included.
    def self.inherit_resources
      include InheritedResources::Controller
      initialize_resources_class_accessors!
      create_resources_url_helpers!
    end
  end
end
