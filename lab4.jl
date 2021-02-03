### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 1424e592-35a5-11eb-2037-7f14bff3b881
begin
	using Plots
	plotly()
end

# ╔═╡ 5c54b866-35a9-11eb-21c5-8387700341e2
md"## Užduotis"

# ╔═╡ 7b4f5afa-35a9-11eb-1ff8-9f11415ee246
md"
Išsprendžiame tiesiog pereinant per visas `x` ir `y` galimybes, naudojant duotas ribas.
"

# ╔═╡ 256aaf2e-35a5-11eb-2119-bbe3c9a730bf
begin
	f1((x, y)) = x * (y - 1)
	f2((x, y)) = x^2 + y^2
end

# ╔═╡ 5247481a-35a5-11eb-1f07-ef22e860f164
a, b = 0:0.01:1, 0:0.01:1

# ╔═╡ 4d1f4bec-35a7-11eb-0924-0d15c5cfe190
function calculate(a, b)
	data = []
	for (x, y) = Iterators.product(a, b)
		if y <= x && x <= 4y
			push!(data, (x, y))
		end
	end
	data
end

# ╔═╡ 18996f5a-35a8-11eb-2da9-9bd79669a31b
data = calculate(a, b)

# ╔═╡ 3cb586aa-3632-11eb-2f2d-b74e5ea41e1f
md"$x_1 \text{ ir } x_2 \text{ grafikas (su nurodytais limitais):}$"

# ╔═╡ 6c562890-35a8-11eb-0731-8b0da3cc85bc
scatter(vcat.(data...)..., color = :black, label = "x1 ir x2")

# ╔═╡ 5c2b88e2-3632-11eb-107d-e73ffbcae4d8
md"$x_1(x_2 - 1) \text{ ir } x_1^2 + x_2^2 \text{ grafikas įsistačius } x \text{ ir } y \text{ reikšmes:}$"

# ╔═╡ 17f06c2e-362e-11eb-224e-75e6e8b6701c
scatter(f1.(data), f2.(data), color = :black, label = "x1(x2 - 1) ir x1^2 + x2^2")

# ╔═╡ Cell order:
# ╟─5c54b866-35a9-11eb-21c5-8387700341e2
# ╟─7b4f5afa-35a9-11eb-1ff8-9f11415ee246
# ╠═1424e592-35a5-11eb-2037-7f14bff3b881
# ╠═256aaf2e-35a5-11eb-2119-bbe3c9a730bf
# ╠═5247481a-35a5-11eb-1f07-ef22e860f164
# ╠═4d1f4bec-35a7-11eb-0924-0d15c5cfe190
# ╠═18996f5a-35a8-11eb-2da9-9bd79669a31b
# ╟─3cb586aa-3632-11eb-2f2d-b74e5ea41e1f
# ╠═6c562890-35a8-11eb-0731-8b0da3cc85bc
# ╟─5c2b88e2-3632-11eb-107d-e73ffbcae4d8
# ╠═17f06c2e-362e-11eb-224e-75e6e8b6701c
