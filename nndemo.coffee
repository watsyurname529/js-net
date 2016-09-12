$ ->

    # From the CoffeeScript cookbook
    zip = () ->
        lengthArray = (arr.length for arr in arguments)
        length = Math.min(lengthArray...)
        for i in [0...length]
            arr[i] for arr in arguments

    argmax = (list) ->
        val = list[0]
        pos = 0
        for i in [0...list.length]
            if(list[i] > val)
                val = list[i]
                pos = i
        return pos

    showOutput = ->
        $('#output').addClass('animate').css('opacity', 1.0)

    hideOutput = ->
        $('#output').removeClass('animate').css('opacity', 0.0)

    first_guess_string = ["Is the number a ", "I think it is a ", "My first thought is a ", "I'm going with a "]
    second_guess_string = ["Instead how about a ", "Maybe a ", "On second thought, it is a ", "Wait, let's try a "]

    $("#button").on "click", ->
            input_canvas = document.getElementById("tools_sketch")
            input_ctx = input_canvas.getContext("2d")

            output_canvas = document.getElementById("preview")
            output_ctx = output_canvas.getContext("2d")
            output_ctx.rect(0, 0, output_canvas.width, output_canvas.height);
            output_ctx.fillStyle = '#FFFFFF';
            output_ctx.fill();
            output_ctx.drawImage(input_canvas, 0, 0, 28, 28)

            #From stackblur.js : http://www.quasimondo.com/StackBlurForCanvas/StackBlurDemo.html
            stackBlurCanvasRGB("preview", 0, 0, 28, 28, 1) 

            output_image = output_ctx.getImageData(0, 0, 28, 28)
            nn_image = output_image.data

            nn_input = []
            for i in [0...nn_image.length] by 4
                avg_pixel = (nn_image[i] + nn_image[i+1] + nn_image[i+2]) / 3
                avg_pixel = (255.0 - avg_pixel) / 255.0
                nn_input.push(avg_pixel)

            # console.log(nn_input[0], nn_input[1], nn_input[2], nn_input.length)

            data = nn_json
            bias = []
            weights = []
            size = data.size
            # console.log(size.length)

            for i in [0...size.length-1] #The '...' operator indicates a range excluding the last value
                bias.push(math.matrix(data.bias[i]))
                weights.push(math.matrix(data.weights[i]))

            z_matrix = math.matrix(nn_input)
            z_matrix = math.resize(z_matrix, [nn_input.length, 1])

            #CoffeeScript needs the [w, b] enclosed in brackets unlike Python
            for [w, b] in zip(weights, bias)
                # console.log(z_matrix.size())
                # console.log(w.size())
                # console.log(b.size())
                z_matrix = math.multiply(w, z_matrix)
                z_matrix = math.add(z_matrix, b)
                z_matrix = math.map(z_matrix, func = (val) ->
                    math.tanh(val)
                    # 1.0 / (1.0 + math.exp(-val))
                )            

            nn_guess_array = math.resize(z_matrix, [10])
            nn_guess = argmax(nn_guess_array._data)

            nn_second_guess_array = nn_guess_array.clone()
            nn_second_guess_array._data[nn_guess] = 0
            nn_second_guess = argmax(nn_second_guess_array._data)
            
            console.log(math.format(nn_guess_array, 14))
            console.log(math.format(nn_guess, 14), "or", math.format(nn_second_guess, 14))

            setTimeout(showOutput, 25)
            $("#output").html(
                '<p class="guess">' + first_guess_string[math.randomInt(0, first_guess_string.length)] + 
                math.format(nn_guess, 1) + '?' + '</p>' +
                '<p class="guess">' + second_guess_string[math.randomInt(0, second_guess_string.length)] + 
                math.format(nn_second_guess, 1) + '?' + '</p>' + 
                '<p>' + 'My total output: ' + math.format(nn_guess_array, 7) + '</p>'
            )
            hideOutput()