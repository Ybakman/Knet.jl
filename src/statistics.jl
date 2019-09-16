import Statistics: mean, std, stdm, var, varm

mean(a::KnetArray; o...) = (b = sum(a; o...); b .* convert(eltype(b),(length(b)/length(a))))
mean(f, a::KnetArray) = sum(f, a) / length(a)
std(x::KnetArray, args...; kws...) = sqrt.(var(x, args...; kws...))
stdm(x::KnetArray, args...; kws...) = sqrt.(varm(x, args...; kws...))
var(x::KnetArray; corrected::Bool=true, mean=nothing, dims=:)=_varm(x, something(mean, Statistics.mean(x,dims=dims)); corrected=corrected, dims=dims)
varm(x::KnetArray, m; corrected::Bool=true, dims=:)=_varm(x, m; corrected=corrected, dims=dims)

function _varm(x::KnetArray, m; corrected::Bool=true, dims=:)
    s = sum(abs2, x .- m; dims=dims)
    r = length(x) ÷ length(s) - Int(corrected)
    s ./ r
end
