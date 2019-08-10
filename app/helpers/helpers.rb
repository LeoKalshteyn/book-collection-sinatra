class Helpers
  # finds session's user ID of current user.
  def self.current_user(session)
    User.find(session[:user_id])
  end

# checks if user is logged in session
  def self.is_logged_in?(session)
    session.include?(:user_id)
  end
end
