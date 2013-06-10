# encoding: utf-8

module AuthenticationMacros
  def should_not_require_authentication(options)
    controller = options.delete(:controller)
    action     = options.delete(:action) || 'index'
    method     = options.delete(:method) || 'get'

    describe "#{controller.to_s.camelize}Controller".constantize, :type => :controller do
      describe "#{method.upcase} '#{action}'" do
        context "as not authenticated" do
          it "should not require me to log in" do
            send(method, action, options)
            response.should_not redirect_to(new_user_session_path)
          end
        end
      end
    end
  end

  def should_require_user_authentication(options)
    controller = options.delete(:controller)
    action     = options.delete(:action) || 'index'
    method     = options.delete(:method) || 'get'

    describe "#{controller.to_s.camelize}Controller".constantize, :type => :controller do
      describe "#{method.upcase} '#{action}'" do
        context "as not authenticated" do
          before(:each) do
            send(method, action, options)
          end

          it "should require redirect me to the log in page" do
            response.should redirect_to(new_user_session_path)
          end

          it "should set an error message explaining that they must log in as an user" do
            flash[:alert].should == 'You need to sign in or sign up before continuing.'
          end
        end

        context "as an authenticated user" do
          it "should not require me to log in" do
            sign_in(FactoryGirl.create(:user))
            send(method, action, options)
            response.should_not redirect_to(new_user_session_path)
          end
        end
      end
    end
  end

  def should_require_admin_authentication(options)
    controller = options.delete(:controller)
    action     = options.delete(:action)
    method     = options.delete(:method) || 'get'

    describe "#{controller.to_s.camelize}Controller".constantize, :type => :controller do
      describe "#{method.upcase} '#{action}'" do
        context "as not authenticated" do
          before(:each) do
            send(method, action, options)
          end

          it "should require redirect me to the log in page" do
            response.should redirect_to(new_user_session_path)
          end

          it "should set an error message explaining that they must log in as an administrator" do
            flash[:notice].should == 'You must login as an admin to access this view.'
          end
        end

        context "as an authenticated user" do
          before(:each) do
            sign_in(FactoryGirl.create(:user))
            send(method, action, options)
          end

          it "should require redirect me to the front page" do
            response.should redirect_to(root_path)
          end

          it "should set an error message explaining that only administrators can access the page" do
            flash[:alert].should == 'You must be an admin to access this view.'
          end
        end

        context "as an authenticated administrator" do
          it "should not require me to log in" do
            sign_in(FactoryGirl.create(:admin))
            send(method, action, options)
            response.should_not redirect_to(new_user_session_path)
          end
        end
      end
    end
  end
end
