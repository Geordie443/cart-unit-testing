ExUnit.start()
ExUnit.configure(exclude: :skip, trace: true)

defmodule ItemTest do
  import Ecto.Changeset
  alias Cart.Item
  # alias Cart.Item.Description
  alias Cart.ItemMock, as: Mock
  use ExUnit.Case, async: true

  @mock_item_1 %{
    name: "Shoe",
    price: "10.5",
    description: %{
      words: "description",
      sold: false,
      tag: [
        %{
          _id: "ertyert5544",
          value: "large",
          number: 2342
        },
        %{
          _id: "erdewffrffr4",
          value: "small",
          number: 2454
        }
      ]
    }
  }

  # @tag :skip
  test "Test Embedded Description" do
    changeset = Item.changeset(%Item{}, @mock_item_1)
    IO.inspect(changeset, label: "Changeset:\n")
    assert changeset.valid? === true
  end

  @tag :skip
  test "Test Local Changeset and Fields" do
    changeset = changeset_local(%Item{}, @mock_item_1)
    IO.inspect(changeset, label: "Changeset:\n")
    assert changeset.valid? === true
  end

  @tag :skip
  test "Test ItemMock Alias" do
    changeset = Item.changeset(%Item{}, Mock.mockitem())
    IO.inspect(changeset, label: "Changeset:\n")
    assert changeset.valid? === true
  end

  # -------- LOCAL CHANGESET -------------

  @fields ~w(name price)

  defp changeset_local(data, params) do
    data
    |> cast(params, @fields)
    # |> cast_embed(:description)
    |> validate_required([:name, :price])
    |> validate_number(:price, greater_than_or_equal_to: Decimal.new(0))
  end
end
