defmodule WalletWeb.PageController do
  use WalletWeb, :controller

  alias Wallet.Expenses

  def index(conn, _params) do
    expenses = Expenses.list_expenses()
    render(conn, "index.html", expenses: expenses)
  end
end
