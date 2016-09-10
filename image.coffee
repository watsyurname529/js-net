$ -> 

    $("#button").on "click", ->
        c = document.getElementById("tools_sketch")
        ctx = c.getContext("2d")
        
        # ctx.scale(0.1, 0.1);
        # ctx.rect(0, 0, c.width, c.height);
        # ctx.fillStyle = '#000000';
        # ctx.fill();

        # imageData = ctx.getImageData(0, 0, 280, 280)
        # data = imageData.data
        # console.log(data[0], data[1], data[2], data[3], data.length)

        c2 = document.getElementById("output")
        ctx2 = c2.getContext("2d")
        ctx2.rect(0, 0, c2.width, c2.height);
        ctx2.fillStyle = '#FFFFFF';
        ctx2.fill();
        ctx2.drawImage(c, 0, 0, 28, 28)

        imageData = ctx2.getImageData(0, 0, 280, 280)
        data = imageData.data
        console.log(data[0], data[1], data[2], data[3], data.length)