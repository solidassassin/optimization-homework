### A Pluto.jl notebook ###
# v0.12.10

using Markdown
using InteractiveUtils

# ╔═╡ d029d5da-2534-11eb-0c8a-47ea4dab79ff
begin
	using Optim
	using Plots
	plotly()
end

# ╔═╡ 2c80c816-252b-11eb-132d-73b886804640
md"## Pirma užduotis"

# ╔═╡ 6d12a168-2541-11eb-300c-695c9f673b88
md"
Sprendimas yra gana paprastas, nors aš dar pilnai neišmokęs naudotis Julia paketais. Tiesiog duotas funkcijas diferencijuojame ir lyginames nuliui: $f' (x) = 0$. Taip susirandame savo $x$ reikšmę ir įsistatome į funkciją. Badžiau viską programatiškai daryti.
"

# ╔═╡ ec6fd698-2b26-11eb-2579-a190180196c8
rng = -10:10

# ╔═╡ fda1d1b2-253d-11eb-1d7d-edf59979575e
x0 = zeros(1)

# ╔═╡ f208a7e2-2540-11eb-1ab9-cb1e62bacb86
md"$f(x) = \frac{x^6}{6} - x^3 + 2x$"

# ╔═╡ 686ed3fa-253e-11eb-0477-1be51589ccbb
begin
	fn1(x) = x[1]^6/6 - x[1]^3 + 2x[1]
	optimize(fn1, x0, Newton(), autodiff = :forward)
end

# ╔═╡ 6052e984-2b26-11eb-0bb0-4516f14e577d
plot(rng, fn1, width = 2, label = "fn1")

# ╔═╡ 205441b0-2541-11eb-283d-675a7667fa90
md"$f(x) = \frac{x + 1}{exp(x - 1) -1}$"

# ╔═╡ 8388c060-2540-11eb-1155-7df4c383ca31
begin
	fn2(x) = x[1] + 1 / (exp(x[1] - 1) -1)
	optimize(fn2, x0, Newton(), autodiff = :forward)
end

# ╔═╡ 8b678848-2b26-11eb-35f0-b7a222440782
plot(rng, fn2, width = 2, label = "fn2")

# ╔═╡ 4088ffca-2541-11eb-3013-d5be8df3c829
md"$f(x) = x - sin(x)$"

# ╔═╡ 844d84d4-2540-11eb-32e6-0f981efe1579
begin
	fn3(x) = x[1] - sin(x[1])
	optimize(fn3, x0, Newton(), autodiff = :forward)
end

# ╔═╡ ae6be178-2b26-11eb-052b-4564deb07e44
plot(rng, fn3, width = 2, label = "fn3")

# ╔═╡ 1f6f84f0-2549-11eb-36ba-5de82b934d21
md"
`optimize` funkcija ieško globalaus minimumo, todėl pavyzdžiui antros užduoties apskaičiuoti negali.
"

# ╔═╡ 2fb1b37a-2548-11eb-3abf-b505a497c3bf
md"
Vieno kintamojo funkcijos optimizavimui panaudoti daugelio kintamųjų
optimizavimo procedūras neįmanoma.
"

# ╔═╡ 91ead3f0-2534-11eb-043b-198c3f364721
md"## Antra užduotis"

# ╔═╡ 598c73a2-2529-11eb-361b-cb12ed13d195
begin
	x_axis = -10:10
	y_axis = -10:10
end

# ╔═╡ 5ae2f224-2533-11eb-262d-fddb258959c5
md"#### Mūsu funkcijos:"

# ╔═╡ 48786f74-2528-11eb-251d-7fb653df29d1
begin
	f1(x, y) = x^2 + y^2
	f2(x, y) = x^2 + 100y^2
	f3(x, y) = 100(y - x^2)^2 + (1 - x)^2
	f4(x, y) = sin(x^2 + 3y^2 + 1) / (x^2 + 3y^2 + 1)
	f5(x, y) = x * exp(-x^2 - y^2)
end

# ╔═╡ c44a344c-2533-11eb-0911-1f69dc5b0b5f
md"$f(x, y) = x^2 + y^2$"

# ╔═╡ 438635b6-2533-11eb-03c4-f367ac10c37a
plot(x_axis, y_axis, f1, st = :surface)

# ╔═╡ ea5b0cf4-2533-11eb-26ca-21c3680173ad
md"$f(x, y) = x^2 + 100y^2$"

# ╔═╡ 234526cc-2533-11eb-3275-914894263b25
plot(x_axis, y_axis, f2, st = :surface)

# ╔═╡ 041b56bc-2534-11eb-1b5c-19dc27ba077c
md"$f(x, y) = 100(y - x^2)^2 + (1 - x)^2$"

# ╔═╡ 303297d4-2533-11eb-39d4-fd4323cf63c4
plot(x_axis, y_axis, f3, st = :surface)

# ╔═╡ 0e62f170-2534-11eb-3c23-4567fced4a36
md"$f(x, y) = \frac{sin(x^2 + 3y^2 + 1)}{x^2 + 3y^2 + 1}$"

# ╔═╡ 71183e1e-2533-11eb-2b0a-4701a7001605
plot(x_axis, y_axis, f4, st = :surface)

# ╔═╡ 4ef2c5ee-2534-11eb-037a-cff9ee82e02b
md"$f(x, y) = x * exp(-x^2 - y^2)$"

# ╔═╡ 71c59958-2533-11eb-1ad3-bf7b7fa34a49
plot(x_axis, y_axis, f5, st = :surface)

# ╔═╡ 663962ea-2547-11eb-1df8-7fc77d156b01
md"#### Funkcijų minimizavimas"

# ╔═╡ d5920cb4-2547-11eb-1eb5-67b40d5e0ca2
md"
Sprendimas panašus kaip pirmos užduoties. Difirencijuojame, tačiau 2 kartus (atmesdami $x$ ir $y$).
"

# ╔═╡ 9ef31a8e-2541-11eb-2b71-5136e0b14a0a
x1 = zeros(2)

# ╔═╡ 28aeb894-2547-11eb-0919-5b1a00f08614
md"$f(x, y) = x^2 + y^2$"

# ╔═╡ 500de8d0-2543-11eb-0b45-bbdd0f92796d
begin
	fn4(x) = x[1]^2 + x[2]^2
	optimize(fn4, x1, autodiff = :forward)
end

# ╔═╡ 412875d6-2547-11eb-3c25-41beaa3459e1
md"$f(x, y) = x^2 + 100y^2$"

# ╔═╡ 5b939b5a-2545-11eb-17c9-19175b11c7b2
begin
	fn5(x) = x[1]^2 + 100x[2]^2
	optimize(fn5, x1, autodiff = :forward)
end

# ╔═╡ 567e73b8-2547-11eb-1a5f-0fed02b8ca16
md"$f(x, y) = 100(y - x^2)^2 + (1 - x)^2$"

# ╔═╡ 77b997c6-2545-11eb-01ff-c34489d7e2af
begin
	fn6(x) = 100 * (x[2] - x[1]^2)^2 + (1 - x[1])^2
	optimize(fn6, x1, autodiff = :forward)
end

# ╔═╡ Cell order:
# ╟─2c80c816-252b-11eb-132d-73b886804640
# ╟─6d12a168-2541-11eb-300c-695c9f673b88
# ╠═d029d5da-2534-11eb-0c8a-47ea4dab79ff
# ╠═ec6fd698-2b26-11eb-2579-a190180196c8
# ╠═fda1d1b2-253d-11eb-1d7d-edf59979575e
# ╟─f208a7e2-2540-11eb-1ab9-cb1e62bacb86
# ╠═686ed3fa-253e-11eb-0477-1be51589ccbb
# ╠═6052e984-2b26-11eb-0bb0-4516f14e577d
# ╟─205441b0-2541-11eb-283d-675a7667fa90
# ╠═8388c060-2540-11eb-1155-7df4c383ca31
# ╠═8b678848-2b26-11eb-35f0-b7a222440782
# ╟─4088ffca-2541-11eb-3013-d5be8df3c829
# ╠═844d84d4-2540-11eb-32e6-0f981efe1579
# ╠═ae6be178-2b26-11eb-052b-4564deb07e44
# ╟─1f6f84f0-2549-11eb-36ba-5de82b934d21
# ╟─2fb1b37a-2548-11eb-3abf-b505a497c3bf
# ╟─91ead3f0-2534-11eb-043b-198c3f364721
# ╠═598c73a2-2529-11eb-361b-cb12ed13d195
# ╟─5ae2f224-2533-11eb-262d-fddb258959c5
# ╠═48786f74-2528-11eb-251d-7fb653df29d1
# ╟─c44a344c-2533-11eb-0911-1f69dc5b0b5f
# ╠═438635b6-2533-11eb-03c4-f367ac10c37a
# ╟─ea5b0cf4-2533-11eb-26ca-21c3680173ad
# ╠═234526cc-2533-11eb-3275-914894263b25
# ╟─041b56bc-2534-11eb-1b5c-19dc27ba077c
# ╠═303297d4-2533-11eb-39d4-fd4323cf63c4
# ╟─0e62f170-2534-11eb-3c23-4567fced4a36
# ╠═71183e1e-2533-11eb-2b0a-4701a7001605
# ╟─4ef2c5ee-2534-11eb-037a-cff9ee82e02b
# ╠═71c59958-2533-11eb-1ad3-bf7b7fa34a49
# ╟─663962ea-2547-11eb-1df8-7fc77d156b01
# ╟─d5920cb4-2547-11eb-1eb5-67b40d5e0ca2
# ╠═9ef31a8e-2541-11eb-2b71-5136e0b14a0a
# ╟─28aeb894-2547-11eb-0919-5b1a00f08614
# ╠═500de8d0-2543-11eb-0b45-bbdd0f92796d
# ╟─412875d6-2547-11eb-3c25-41beaa3459e1
# ╠═5b939b5a-2545-11eb-17c9-19175b11c7b2
# ╟─567e73b8-2547-11eb-1a5f-0fed02b8ca16
# ╠═77b997c6-2545-11eb-01ff-c34489d7e2af
