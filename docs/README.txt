Update
elm-stuff\packages\elm-community\webgl\2.0.3\src\Native\WebGL.js

line 576
preserveDrawingBuffer: true

because next logic is needed for readPixels
canvas.getContext("experimental-webgl", {preserveDrawingBuffer: true});


commented out lines that contain: cache.buffers[entity.buffer.guid
lines:
449
453

var buffer; //= model.cache.buffers[entity.buffer.guid];

      if (!buffer) {
        buffer = doBindSetup(gl, entityType, entity.buffer);
        //model.cache.buffers[entity.buffer.guid] = buffer;
      }


these lines cached the triangle buffers
anyway these buffers are going to be recreated each time
so there will be infinitively alot cached,
causing a memory leak

https://groups.google.com/forum/#!topic/elm-discuss/NzUX9AEulxg
//*/