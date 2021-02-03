### A Pluto.jl notebook ###
# v0.12.16

using Markdown
using InteractiveUtils

# ╔═╡ 33116200-35aa-11eb-2f0b-77f71d0ebf6d
begin
	using Clustering
	using Optim
	using Plots
	plotly()
end

# ╔═╡ 87073d6a-35b6-11eb-333d-c981a88e835b
md"## Pirma užduotis"

# ╔═╡ 9a050c12-35b6-11eb-323a-91c80f7bf371
md"Tinkama sandelių padėtį susirandame naudodami `kmeans` funkciją."

# ╔═╡ 6a6aaf6a-35aa-11eb-2c14-e186e5fb8ef9
printer_amount = 10

# ╔═╡ e0b7e398-35aa-11eb-1e9e-c7dbbf3f6955
printers = rand(1:100, 2, printer_amount)

# ╔═╡ 8446f130-35af-11eb-0503-af3b4882f794
result = kmeans(printers, 2, maxiter = 100)

# ╔═╡ 3da8efcc-35b3-11eb-3a60-75022d147957
centers = result.centers

# ╔═╡ 5bc94864-35b1-11eb-2a89-bd0ac6f350ab
begin
	scatter(printers[1, :], printers[2, :], color = :black, label = "Spaustuvės", markersize = 5)
	nothing
end

# ╔═╡ c4dbfcde-35b6-11eb-253b-4998051eb2d2
md"Mūsų gautos sandelių vietos:"

# ╔═╡ 5397f54a-35b2-11eb-200c-eb7dda44358f
scatter!(centers[1, :], centers[2, :], color = :red, label = "Sandeliai", markersize = 6)

# ╔═╡ e5bd6f50-35b6-11eb-37ab-61a914f3469e
md"## Antra užduotis"

# ╔═╡ f295f152-35b6-11eb-12bf-cd7913a1cb36
md"Susirandame tinkama popieriaus poreikį panaudoje `result.assignments` pažiūrėti kokiam sandeliui kokios spaustuvės buvo priskirtos."

# ╔═╡ 9a35fac2-35b4-11eb-1870-91717408f70c
paper_demand = rand(1000:100_000, 10)

# ╔═╡ 2beba7d0-35b7-11eb-13cd-5f33c2758d8d
md"Reikiamas popieriaus kiekis:"

# ╔═╡ 48a00e64-35b4-11eb-31a6-554a88050092
begin
	find_demand(x) = [a for (a, b) = zip(paper_demand, result.assignments) if b == x] |> sum
	(warehouse1 = find_demand(1), warehouse2 = find_demand(2))
end

# ╔═╡ Cell order:
# ╠═33116200-35aa-11eb-2f0b-77f71d0ebf6d
# ╟─87073d6a-35b6-11eb-333d-c981a88e835b
# ╟─9a050c12-35b6-11eb-323a-91c80f7bf371
# ╠═6a6aaf6a-35aa-11eb-2c14-e186e5fb8ef9
# ╠═e0b7e398-35aa-11eb-1e9e-c7dbbf3f6955
# ╠═8446f130-35af-11eb-0503-af3b4882f794
# ╠═3da8efcc-35b3-11eb-3a60-75022d147957
# ╠═5bc94864-35b1-11eb-2a89-bd0ac6f350ab
# ╟─c4dbfcde-35b6-11eb-253b-4998051eb2d2
# ╠═5397f54a-35b2-11eb-200c-eb7dda44358f
# ╟─e5bd6f50-35b6-11eb-37ab-61a914f3469e
# ╟─f295f152-35b6-11eb-12bf-cd7913a1cb36
# ╠═9a35fac2-35b4-11eb-1870-91717408f70c
# ╟─2beba7d0-35b7-11eb-13cd-5f33c2758d8d
# ╠═48a00e64-35b4-11eb-31a6-554a88050092
