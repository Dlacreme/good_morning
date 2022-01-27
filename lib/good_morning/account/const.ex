defmodule GM.Account.Const do
  defmodule Web do
    def remember_me_cookie, do: "_good_morning_web_user_remember_me"
  end

  defmodule TokenType do
    def authorization, do: "authorization"
    def password_recovery, do: "password_recovery"
    def account_validation, do: "account_validation"
  end

  defmodule UserRole do
    def admin, do: "admin"
    def user, do: "user"
  end
end
