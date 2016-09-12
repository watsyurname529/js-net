fs = require('fs')
math = require('mathjs')

json_file = fs.readFileSync('../neural-net/mnist.json', 'utf8')
data = JSON.parse(json_file)

#Zip from the CoffeeScript cookbook
zip = () ->
  lengthArray = (arr.length for arr in arguments)
  length = Math.min(lengthArray...)
  for i in [0...length]
    arr[i] for arr in arguments

bias = []
weights = []
size = data.size
console.log(size.length)

for i in [0...size.length-1] #The '...' operator indicates a range excluding the last value
    bias.push(math.matrix(data.bias[i]))
    weights.push(math.matrix(data.weights[i]))

z_matrix = math.ones(784, 1)
z_matrix = math.map(z_matrix, func = (val) ->
    math.random(0,1)
)
# console.log(z_matrix)

#CoffeeScript needs the [w, b] enclosed in brackets unlike Python
for [w, b] in zip(weights, bias)
    # console.log(z_matrix.size())
    # console.log(w.size())
    z_matrix = math.multiply(w, z_matrix)
    z_matrix = math.add(z_matrix, b)
    z_matrix = math.map(z_matrix, func = (val) ->
        math.tanh(val)
    )

console.log(z_matrix)