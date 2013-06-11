module Authorization

  def self.included(base)
    base.extend(ClassMethods)
  end

  def perform_authentication
    first_applicable_rule = all_authorization_rules.find do |rule|
      applicable_authorization_rule?(rule, action_name)
    end

    invoke_authorization_rule(first_applicable_rule) if first_applicable_rule
  end

  def all_authorization_rules
    self.class.ancestors.inject([]) do |rules, ancestor|
      if ancestor.respond_to?(:authorization_rules_stack) && !ancestor.authorization_rules_stack.empty?
        rules + ancestor.authorization_rules_stack
      else
        rules
      end
    end
  end

  def invoke_authorization_rule(rule)
    instance_eval(&rule[:method])
  end

  def applicable_authorization_rule?(rule, action)
    if rule[:only]
      [rule[:only]].flatten.map(&:to_s).include?(action)
    elsif rule[:except]
      ![rule[:except]].flatten.map(&:to_s).include?(action)
    else
      true
    end
  end

  def permission_denied(message, path = new_user_session_url)
    session[:return_to] = request.fullpath if request.get?
    flash[:alert] = message
    redirect_to path
  end

  def request_referer_if_on_current_domain
    if request.referer and request.referer.include? request.host
      request.referer
    end
  end

  module ClassMethods

    def no_authorization!(options = {})
      add_authorization_rule(options) do
        # No operation
      end
    end

    def authorize_admin!(options = {})
      add_authorization_rule(options) do
        if user_signed_in?
          unless current_user.admin?
            permission_denied(t('authorization.requires_admin_privileges'), root_path)
          end
        else
          permission_denied(t('authorization.requires_user_privileges'))
        end
      end
    end

    def authorize_user!(options = {})
      add_authorization_rule(options) do
        unless user_signed_in?
          permission_denied(t('authorization.requires_user_privileges'))
        end
      end
    end

    def authorize!(options = {}, &block)
      add_authorization_rule(options, &block)
    end

    def add_authorization_rule(options = {}, &block)
      skip_before_filter :perform_authentication
      before_filter :perform_authentication

      authorization_rules_stack.unshift(options.merge({ :method => block }))
    end

    def authorization_rules_stack
      class_variable_set(:@@authorization_rules_stack, {}) unless class_variable_defined?(:@@authorization_rules_stack)
      class_variable_get(:@@authorization_rules_stack)[name] ||= []
    end

  end

end
