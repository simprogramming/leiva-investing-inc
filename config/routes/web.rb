controller :sites do
  get "/", action: :home, as: :home
end
root "sites#home"
