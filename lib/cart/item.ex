defmodule Cart.Item do
  use Ecto.Schema
  import Ecto.Changeset
  alias Cart.Item

  # alias Cart.InvoiceItem

  @primary_key {:id, :binary_id, autogenerate: true}
  schema "items" do
    field(:name, :string)
    field(:price, :decimal, precision: 12, scale: 2)
    embeds_one(:description, Item.Description)

    # has_many(:invoice_items, InvoiceItem)

    timestamps()
  end

  @fields ["name", "price"]

  def changeset(data, params \\ %{}) do
    data
    |> cast(params, @fields)
    |> cast_embed(:description)
    |> validate_required([:name, :price])
    |> validate_number(:price, greater_than_or_equal_to: Decimal.new(0))
  end

  defmodule Description do
    use Ecto.Schema

    @primary_key false
    schema "" do
      field(:words, :string)
      field(:sold, :boolean)
    end

    @description_fields ~w(words sold)

    def changeset(description = %Description{}, params \\ %{}) do
      description
      |> cast(params, @description_fields)
      |> validate_required([:words, :sold])
    end
  end
end
