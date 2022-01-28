%GM.Account.Users{}
|> GM.Account.Users.changeset_register(%{
  email: "good@morning.com",
  password: "toto4242",
  type_id: "admin",
  joined_at: DateTime.utc_now()
})
|> GM.Repo.insert()
