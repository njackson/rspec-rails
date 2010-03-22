require 'action_controller/test_case'

module ControllerExampleGroupBehaviour
  attr_reader :response

  def self.included(mod)
    mod.before do
      @_result = Struct.new(:add_assertion).new
      @router = Rails.application.routes
      setup_controller_request_and_response
    end

    def mod.setup(*methods)
    end

    def mod.teardown(*methods)
    end

    def mod.controller_class
      metadata[:example_group][:describes]
    end
  end

  Rspec.configure do |c|
    c.extend ActionController::TestCaseClassMethods, :example_group => { :file_path => /\bspec\/controllers\// }
    [self, Test::Unit::Assertions, ActionController::TestCaseInstanceMethods, ActionController::TemplateAssertions].each do |m|
      c.include m, :example_group => { :file_path => /\bspec\/controllers\// }
    end
  end
end
