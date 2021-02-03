### A Pluto.jl notebook ###
# v0.12.18

using Markdown
using InteractiveUtils

# ╔═╡ 51e5a9f8-2ac8-11eb-2bdf-0109c47b804e
begin
	using Plots
	using Zygote
	using Optim
	plotly()
end

# ╔═╡ ee7ebcc6-359a-11eb-0a9d-292de9a39dcb
md"## Pirma užduotis"

# ╔═╡ 922fdf18-359c-11eb-3928-51acfa3cb8bf
md"### _a_ dalis"

# ╔═╡ 892a9c76-2ac7-11eb-2ba6-af3910e97a48
f(x, y) = 100(y - x^2)^2 + (1 - x)^2

# ╔═╡ 7ba4ae72-359c-11eb-1d0a-53749fed27ae
md"Mūsų modelis kurį naudosime perduoti ir atnaujinti informaciją:"

# ╔═╡ 73d5dd94-3635-11eb-3b1e-9b08e30a03db
mutable struct Model
	args::Array{Float32}
	η::Float32
	ϵ::Float32
end

# ╔═╡ 7325ecbe-3639-11eb-25fe-db50e5686035
md"Mūsų gradientinio nusileidimo funkciją (priima įvairų argumentų skaičių):"

# ╔═╡ c22689f8-35a4-11eb-38f5-110557dfa269
function train!(m::Model, func::Function; iterstop=100_000)
	data = []
	counter = 0
	while counter < iterstop
		df = gradient(func, m.args...)
		z = func(m.args...)
		if df .^ 2 |> sum |> sqrt < m.ϵ
			break
		end
		push!(data, (m.args..., z))
		m.args .-= df .* m.η
		counter += 1
	end
	data
end

# ╔═╡ 561ad14a-359c-11eb-083e-0368fd4712de
md"Užtruko apie 74000 iteracijų kol buvo surastas lokalus minimumas."

# ╔═╡ 66df04c2-357b-11eb-1b02-dfc05599865d
begin
	const m = Model([-1.0, 1.0], 0.001, 1e-4)
	data_full = train!(m, f)
	data = data_full[1:100:end]
	data_full |> last
end

# ╔═╡ d40efd14-358c-11eb-1072-d36da2338fa9
rng = -1:0.1:1

# ╔═╡ f9d2e740-30c0-11eb-3956-ade98cb27f02
begin
	surface(rng, rng, f)
	nothing
end

# ╔═╡ cc76b836-359c-11eb-372a-a5a06a72062e
md"Čia taškų skaičius sumažintas (imtas kas šimtasis elementas) dėl grožio."

# ╔═╡ df26d4bc-30c3-11eb-172a-fbff08a10154
scatter3d!(vcat.(data...)..., color = :white, markersize = 2, label = "Minimum search")

# ╔═╡ a18fab14-359c-11eb-31f2-17cb8ffab6de
md"### _b_ dalis"

# ╔═╡ 373aa2d0-35a3-11eb-2876-89e5a57376c2
begin
	const m1 = Model([0.5, 0.0], 0.001, 1e-4)
	data1 = train!(m1, f)[1:100:end]
	
	const m2 = Model([0.0, 0.5], 0.001, 1e-4)
	data2 = train!(m2, f)[1:100:end]
	
	const m3 = Model([1.0, 0.0], 0.001, 1e-4)
	data3 = train!(m3, f)[1:100:end]
end

# ╔═╡ f8ab25b8-359c-11eb-06b9-dd1023958961
begin
	surface(rng, rng, f)
	nothing
end

# ╔═╡ 34f6fa78-35a3-11eb-1bb3-7969511b3df3
begin
	scatter3d!(vcat.(data1...)..., color = :red, markersize = 2, label = "Minimum search 1")
	nothing
end

# ╔═╡ 204358ec-35a3-11eb-32ef-75ea8bb5cdd1
begin
	scatter3d!(vcat.(data2...)..., color = :blue, markersize = 2, label = "Minimum search 2")
	nothing
end

# ╔═╡ 977b077c-35a4-11eb-3c8e-b33afdf166fc
md"Gradientinio nusileidimo kelias teisingas, tik blogai matosi, nes taškai dengia vienas kitą."

# ╔═╡ e51e5ab6-35a0-11eb-01be-9f2be4cc7e8e
scatter3d!(vcat.(data3...)..., color = :white, markersize = 2, label = "Minimum search 3")

# ╔═╡ b89e814c-35a4-11eb-3bb3-4520e8e1da8a
md"## Antra užduotis"

# ╔═╡ b7e74c7a-363a-11eb-0b5d-0bc1617c9c9c
md"Susikuriame funkciją su keturiais argumentais"

# ╔═╡ b154ac38-3638-11eb-0629-9d19cc190384
f2(x1, x2, x3, x4) = x1 + x2 + x3 + x4

# ╔═╡ cd81ac6a-363a-11eb-1824-2f5737688580
md"Minimumas nerastas, nes tai tokio tipo funkcija kur ir toliau mažės minimumo reikšmė, funkcija sustojo vien dėl to, nes buvo pasiektas maksimalus iteracijų skaičius (`100 000`)."

# ╔═╡ 2d7739de-3639-11eb-028a-694c561ea6bd
begin
	m4 = Model([1.0, 0.0, 1.0, 0.0], 0.001, 1e-4)
	f2_minimum = train!(m4, f2) |> last |> last
end

# ╔═╡ 375b29d6-359b-11eb-17be-13d5c264e95c
md"## Trečia užduotis"

# ╔═╡ 4827d6a6-359b-11eb-3515-3d78fdba336d
md"Panaudojame `optimize` funkcija iš `Optim` paketo."

# ╔═╡ a214afd2-3590-11eb-1fcd-dd3134301d63
fo(x) = 100(x[2] - x[1]^2)^2 + (1 - x[1])^2

# ╔═╡ 63cac444-3590-11eb-3ee7-8b14d728a2df
optimize(fo, [-1.0, 1.0])

# ╔═╡ 74fee3fe-359b-11eb-06ad-ffef61b9e38e
md"## Atsakymai"

# ╔═╡ 7ef774ca-359b-11eb-222a-b12cfba1d10f
md"
1. `0.001` \"mokymo\" dažnis buvo tinkamas, padidinus iki `0.002`, buvo matomi zigzagai ir mano manymu tai buvo per didelis skaičius
2. Rezultatas aišku nėra idealus, mokymosi dažnis turėtu būti labai mažas rasti atsakymą idealų.
3. `optimize` funkcija rado mažesnį minimumą už mano.
"

# ╔═╡ Cell order:
# ╠═51e5a9f8-2ac8-11eb-2bdf-0109c47b804e
# ╟─ee7ebcc6-359a-11eb-0a9d-292de9a39dcb
# ╟─922fdf18-359c-11eb-3928-51acfa3cb8bf
# ╠═892a9c76-2ac7-11eb-2ba6-af3910e97a48
# ╟─7ba4ae72-359c-11eb-1d0a-53749fed27ae
# ╠═73d5dd94-3635-11eb-3b1e-9b08e30a03db
# ╟─7325ecbe-3639-11eb-25fe-db50e5686035
# ╠═c22689f8-35a4-11eb-38f5-110557dfa269
# ╟─561ad14a-359c-11eb-083e-0368fd4712de
# ╠═66df04c2-357b-11eb-1b02-dfc05599865d
# ╠═d40efd14-358c-11eb-1072-d36da2338fa9
# ╠═f9d2e740-30c0-11eb-3956-ade98cb27f02
# ╟─cc76b836-359c-11eb-372a-a5a06a72062e
# ╠═df26d4bc-30c3-11eb-172a-fbff08a10154
# ╟─a18fab14-359c-11eb-31f2-17cb8ffab6de
# ╠═373aa2d0-35a3-11eb-2876-89e5a57376c2
# ╠═f8ab25b8-359c-11eb-06b9-dd1023958961
# ╠═34f6fa78-35a3-11eb-1bb3-7969511b3df3
# ╠═204358ec-35a3-11eb-32ef-75ea8bb5cdd1
# ╟─977b077c-35a4-11eb-3c8e-b33afdf166fc
# ╠═e51e5ab6-35a0-11eb-01be-9f2be4cc7e8e
# ╟─b89e814c-35a4-11eb-3bb3-4520e8e1da8a
# ╟─b7e74c7a-363a-11eb-0b5d-0bc1617c9c9c
# ╠═b154ac38-3638-11eb-0629-9d19cc190384
# ╟─cd81ac6a-363a-11eb-1824-2f5737688580
# ╠═2d7739de-3639-11eb-028a-694c561ea6bd
# ╟─375b29d6-359b-11eb-17be-13d5c264e95c
# ╟─4827d6a6-359b-11eb-3515-3d78fdba336d
# ╠═a214afd2-3590-11eb-1fcd-dd3134301d63
# ╠═63cac444-3590-11eb-3ee7-8b14d728a2df
# ╟─74fee3fe-359b-11eb-06ad-ffef61b9e38e
# ╟─7ef774ca-359b-11eb-222a-b12cfba1d10f
