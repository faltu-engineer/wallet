defmodule WalletWeb.PageController do
  use WalletWeb, :controller

  alias Wallet.Expenses
  require Logger

  def index(conn, _params) do
    expenses = Expenses.list_expenses(conn)
    render(conn, "index.html", expenses: expenses)
  end
end
