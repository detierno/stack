require 'spree_core'
require 'spree_stack_hooks'
require 'spree_stack/aprova_facil_stack.rb'

module SpreeStack
  class Engine < Rails::Engine

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.env.production? ? require(c) : load(c)
        
        SpreeAprovaStack.register
      end
    end

    config.to_prepare &method(:activate).to_proc
  end
end
