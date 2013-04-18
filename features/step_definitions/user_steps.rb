Given /^there is a user with ((?:(?:[^ ]+) "(?:[^"]+)")(?:(?:, | and )(?:(?:[^ ]+) "(?:[^"]+)"))*)?$/i do |attributes_string|
  attributes = Hash[attributes_string.split(/, | and /i).map do |attribute_string|
    /(?<key>[^ ]+) "(?<value>[^"]+)"/ =~ attribute_string
    [key.to_sym, value]
  end]

  if attributes.has_key? :password
    attributes[:password_confirmation] = attributes[:password]
  end

  if (user = User.find_by_email attributes[:email])
    user.update_attributes! attributes
  else
    attributes = {
        :name => "John Doe",
        :email => "#{rand(1000)}@gmail.com",
        :tlf => "22222222",
        :password => "password",
        :password_confirmation => "password",
        :accepted_privacy => "1"
    }.merge attributes

    user = User.new attributes
    user.save!
  end
end

Given /^user with email "(.*?)" is admin$/i do |email|
  u = User.find_by_email(email)
  u.admin = true
  u.save!
end