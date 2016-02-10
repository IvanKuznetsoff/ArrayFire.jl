#####################
# Vector operations #
#####################


#Reduction operations

import Base: sum, max, min, any 
export product, alltrue

#Sum 
sum{T}(a::AFAbstractArray{T}) = icxx"af::sum<float>($a);"
sum{T}(a::AFAbstractArray{T}, dim::Integer) = AFArray{T}(icxx"af::sum($a, $(dim -1));")

#Product
product{T}(a::AFAbstractArray{T}) = icxx"af::product<float>($a);"
product{T}(a::AFAbstractArray{T}, dim::Integer) = AFArray{T}(icxx"af::product($a, $(dim -1));")

#Max
max{T}(a::AFAbstractArray{T}) = icxx"af::max<float>($a);"
max{T}(a::AFAbstractArray{T}, dim::Integer) = AFArray{T}(icxx"af::max($a, $(dim -1));")

#Min
min{T}(a::AFAbstractArray{T}) = icxx"af::min<float>($a);"
min{T}(a::AFAbstractArray{T}, dim::Integer) = AFArray{T}(icxx"af::min($a, $(dim -1));")

#Any
any{T}(a::AFAbstractArray{T}) = icxx"af::anyTrue<boolean_t>($a);" != 0
any(a::AFAbstractArray, dim::Integer) = AFArray{Bool}(icxx"af::anyTrue($a, $(dim -1));")

#Alltrue
alltrue{T}(a::AFAbstractArray{T}) = icxx"af::allTrue<boolean_t>($a);" != 0
alltrue(a::AFAbstractArray, dim::Integer) = AFArray{Bool}(icxx"af::allTrue($a, $(dim -1));")

#Count 
countnz{T}(a::AFAbstractArray{T}) = icxx"af::count<float>($a);"
countnz{T}(a::AFAbstractArray{T}, dim::Integer) = AFArray{UInt32}(icxx"af::count($a, $(dim -1));")


#Inclusive Scan Operations

import Base: cumsum, find

#Cumsum
cumsum{T}(a::AFAbstractArray{T}, dim::Integer = 1) = AFArray{T}(icxx"af::accum($a, $(dim - 1));")

#Find
find(a::AFAbstractArray) = AFArray{UInt32}(icxx"af::where($a);")


#Numerical differentiation

import Base: diff, gradient
export diff2

#1D Diff
diff{T}(a::AFAbstractArray{T}, dim::Integer = 1) = AFArray{T}(icxx"af::diff1($a, $(dim-1));")

#2D Siff
diff2{T}(a::AFAbstractArray{T}, dim::Integer = 1) = AFArray{T}(icxx"af::diff2($a, $(dim-1));")

#Gradient
function gradient{T}(a::AFAbstractArray{T})
    dx = AFArray()
    dy = AFArray()
    icxx"af::grad($dx, $dy, $a);"
    AFArray{T}(dx), AFArray{T}(dy)
end