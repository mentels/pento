import Ecto.Query
alias Pento.Repo

alias Pento.{
  Accounts,
  Accounts.User,
  Catalog,
  Catalog.Product,
  Survey,
  Survey.Demographic,
  Survey.Rating
}

Repo.delete_all(Rating)
Repo.delete_all(Demographic)
Repo.delete_all(Catalog.Product)
Repo.delete_all(User)

{:ok, user} =
  Accounts.register_user(%{
    email: "mentel.szymon@gmail.com",
    password: "ahw1WZA4knu*kez@bkz",
    username: "mentels"
  })

Repo.update_all(
  from(u in User, where: u.id == ^user.id),
  set: [confirmed_at: NaiveDateTime.utc_now(:second)]
)

{:ok, demographic} =
  Survey.create_demographic(%{user_id: user.id, gender: "male", year_of_birth: 1988})

{:ok, good_product} =
  Catalog.create_product(%{
    name: "good product",
    unit_price: 100,
    sku: 11_222,
    description: "good product"
  })

{:ok, poor_product} =
  Catalog.create_product(%{
    name: "poor product",
    unit_price: 900,
    sku: 33_999,
    description: "poor product"
  })

{:ok, rating1} = Survey.create_rating(%{user_id: user.id, product_id: good_product.id, stars: 5})
{:ok, rating2} = Survey.create_rating(%{user_id: user.id, product_id: poor_product.id, stars: 1})
