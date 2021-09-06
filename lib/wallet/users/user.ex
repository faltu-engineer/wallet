defmodule Wallet.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    has_many :expenses, Wallet.Expenses.Expense
    timestamps()
  end
end
