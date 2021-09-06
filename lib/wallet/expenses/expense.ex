defmodule Wallet.Expenses.Expense do
  use Ecto.Schema
  import Ecto.Changeset

  schema "expenses" do
    field :amount, :decimal
    field :name, :string
    belongs_to(:user, Wallet.Users.User)
    belongs_to(:category, Wallet.Categories.Category)

    timestamps()
  end

  @doc false
  def changeset(expense, attrs) do
    expense
    |> cast(attrs, [:name, :amount, :user_id, :category_id])
    |> validate_required([:name, :amount, :user_id])
  end
end
