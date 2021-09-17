defmodule Wallet.Expenses do
  @moduledoc """
  The Expenses context.
  """

  import Ecto.Query, warn: false
  alias Wallet.Repo

  alias Wallet.Expenses.Expense

  @doc """
  Returns the list of expenses.

  ## Examples

      iex> list_expenses()
      [%Expense{}, ...]

  """

  def user_expenses(user) when is_nil(user), do: []

  def user_expenses(user) do
    from(e in Expense, where: e.user_id == ^user.id, order_by: [desc: e.updated_at]) |> Repo.all
  end

  def list_expenses(conn) do
    user = Pow.Plug.current_user(conn)
    # query = from e in Expense,
    #           where: e.user_id == ^user.id,
    #           order_by: [desc: e.updated_at]
    # Repo.all(query)
    user_expenses(user)
  end


  defmacro to_char(field, format) do
    quote do
      fragment("to_char(?, ?)", unquote(field), unquote(format))
    end
  end

  def query_amount_sum_over_months do
    Expense
    |> group_by([p], to_char(p.inserted_at, "Mon YYYY"))
    |> order_by([p], desc: to_char(p.inserted_at, "Mon YYYY"))
    |> select([p], { to_char(p.inserted_at, "Mon YYYY"), sum(p.amount)})
  end

  def this_month_spend do
    Repo.all(query_amount_sum_over_months())
  end

  @doc """
  Gets a single expense.

  Raises `Ecto.NoResultsError` if the Expense does not exist.

  ## Examples

      iex> get_expense!(123)
      %Expense{}

      iex> get_expense!(456)
      ** (Ecto.NoResultsError)

  """
  def get_expense!(id), do: Repo.get!(Expense, id)

  @doc """
  Creates a expense.

  ## Examples

      iex> create_expense(%{field: value})
      {:ok, %Expense{}}

      iex> create_expense(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_expense(conn, attrs \\ %{}) do
    user = Pow.Plug.current_user(conn)
    %Expense{user_id: user.id}
    |> Expense.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a expense.

  ## Examples

      iex> update_expense(expense, %{field: new_value})
      {:ok, %Expense{}}

      iex> update_expense(expense, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_expense(%Expense{} = expense, attrs) do
    expense
    |> Expense.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a expense.

  ## Examples

      iex> delete_expense(expense)
      {:ok, %Expense{}}

      iex> delete_expense(expense)
      {:error, %Ecto.Changeset{}}

  """
  def delete_expense(%Expense{} = expense) do
    Repo.delete(expense)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking expense changes.

  ## Examples

      iex> change_expense(expense)
      %Ecto.Changeset{data: %Expense{}}

  """
  def change_expense(%Expense{} = expense, attrs \\ %{}) do
    Expense.changeset(expense, attrs)
  end
end
