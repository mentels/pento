defmodule Pento.CatalogTest do
  use Pento.DataCase

  alias Pento.Catalog

  describe "products" do
    alias Pento.Catalog.Product

    import Pento.CatalogFixtures

    @invalid_attrs %{name: nil, description: nil, unit_price: nil, sku: nil}

    test "list_products/0 returns all products" do
      product = product_fixture()
      assert Catalog.list_products() == [product]
    end

    test "get_product!/1 returns the product with given id" do
      product = product_fixture()
      assert Catalog.get_product!(product.id) == product
    end

    test "create_product/1 with valid data creates a product" do
      valid_attrs = %{
        name: "some name",
        description: "some description",
        unit_price: 120.5,
        sku: 42
      }

      assert {:ok, %Product{} = product} = Catalog.create_product(valid_attrs)
      assert product.name == "some name"
      assert product.description == "some description"
      assert product.unit_price == 120.5
      assert product.sku == 42
    end

    test "create_product/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Catalog.create_product(@invalid_attrs)
    end

    test "create_product/1 with invalid unit_price returns error changeset" do
      assert {:error, %Ecto.Changeset{errors: [{:unit_price, {_, _}} | _]}} =
               Catalog.create_product(%{@invalid_attrs | unit_price: -42})
    end

    test "update_product/2 with valid data updates the product" do
      product = product_fixture()

      update_attrs = %{
        name: "some updated name",
        description: "some updated description",
        unit_price: 456.7,
        sku: 43
      }

      assert {:ok, %Product{} = product} = Catalog.update_product(product, update_attrs)
      assert product.name == "some updated name"
      assert product.description == "some updated description"
      assert product.unit_price == 456.7
      assert product.sku == 43
    end

    test "update_product/2 with invalid data returns error changeset" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.update_product(product, @invalid_attrs)
      assert product == Catalog.get_product!(product.id)
    end

    test "delete_product/1 deletes the product" do
      product = product_fixture()
      assert {:ok, %Product{}} = Catalog.delete_product(product)
      assert_raise Ecto.NoResultsError, fn -> Catalog.get_product!(product.id) end
    end

    test "change_product/1 returns a product changeset" do
      product = product_fixture()
      assert %Ecto.Changeset{} = Catalog.change_product(product)
    end

    test "markdown_product/2 returns a product with the decreased price" do
      product = product_fixture(%{unit_price: 120.5})
      assert {:ok, %Product{} = markdowned_product} = Catalog.markdown_product(product, 20.5)
      assert markdowned_product.unit_price == 100.0
    end

    test "markdown_product/2 with invalid data returns error" do
      product = product_fixture()

      assert {:error, "Markdown amount must be a number"} =
               Catalog.markdown_product(product, :invalid)

      assert product == Catalog.get_product!(product.id)
    end

    test "markdown_product/2 with invalid data returns error changeset (increased unit_price)" do
      product = product_fixture()
      assert {:error, %Ecto.Changeset{}} = Catalog.markdown_product(product, -5)
      assert product == Catalog.get_product!(product.id)
    end

    test "markdown_product/2 with invalid data returns error changeset (negative unit_price)" do
      product = product_fixture()

      assert {:error, %Ecto.Changeset{}} =
               Catalog.markdown_product(product, product.unit_price * 2)

      assert product == Catalog.get_product!(product.id)
    end
  end
end
