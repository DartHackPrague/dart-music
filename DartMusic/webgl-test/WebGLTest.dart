#import('dart:html');


class WebGLTest {

  WebGLRenderingContext gl;
  WebGLProgram program;
  double aspect;
  bool running = false;
  
  double foobar = 0.5; 
  bool adding = true;
  
  
  WebGLTest() {
    CanvasElement canvas = document.query('#drawHere');
    this.aspect = canvas.width / canvas.height;
    this.gl = canvas.getContext("experimental-webgl");
    this.gl.viewport(0, 0, canvas.width, canvas.height);
  }

  void init() {
    
    String vsSource = """
    attribute vec2 a_position;
    void main() {
      gl_Position = vec4(a_position, 0, 1);
    }
    """;
    
    
    String fsSource = """
    precision mediump float;
    uniform vec4 uColor;
    void main() {
      gl_FragColor = uColor;
    }""";
    
    

    WebGLShader vs = this.gl.createShader(WebGLRenderingContext.VERTEX_SHADER);
    this.gl.shaderSource(vs, vsSource);
    this.gl.compileShader(vs);
    
    WebGLShader fs = this.gl.createShader(WebGLRenderingContext.FRAGMENT_SHADER);
    this.gl.shaderSource(fs, fsSource);
    this.gl.compileShader(fs);
    
    WebGLProgram p = this.gl.createProgram();
    this.gl.attachShader(p, vs);
    this.gl.attachShader(p, fs);
    this.gl.linkProgram(p);
    this.gl.useProgram(p);
    
    if (!this.gl.getShaderParameter(vs, WebGLRenderingContext.COMPILE_STATUS)) { 
      print(this.gl.getShaderInfoLog(vs));
    }
    
    if (!gl.getShaderParameter(fs, WebGLRenderingContext.COMPILE_STATUS)) { 
      print(gl.getShaderInfoLog(fs));
    }
    
    if (!this.gl.getProgramParameter(program, WebGLRenderingContext.LINK_STATUS)) { 
      print(this.gl.getProgramInfoLog(program));
    }
    
    this.program = p;
    
  }
  
  void update() {
    
    Float32Array vertices = new Float32Array.fromList([
      -this.foobar, this.foobar * aspect, this.foobar,  this.foobar * aspect,  this.foobar, -this.foobar * aspect
      //-0.5, 0.5 * aspect, 0.5, -0.5 * aspect, -0.5, -0.5 * aspect
    ]);
 
    WebGLBuffer vbuffer = this.gl.createBuffer();
    this.gl.bindBuffer(WebGLRenderingContext.ARRAY_BUFFER, vbuffer);
    this.gl.bufferData(WebGLRenderingContext.ARRAY_BUFFER, vertices, WebGLRenderingContext.STATIC_DRAW);
 
    int itemSize = 2;
    num numItems = vertices.length / itemSize;
 

    this.gl.clearColor(0.9, 0.9, 0.9, 1);
    this.gl.clear(WebGLRenderingContext.COLOR_BUFFER_BIT);
    
    int a_position = this.gl.getAttribLocation(program, "a_position");
    this.gl.enableVertexAttribArray(a_position);
    this.gl.vertexAttribPointer(a_position, itemSize, WebGLRenderingContext.FLOAT, false, 0, 0);

    this.gl.drawArrays(WebGLRenderingContext.TRIANGLES, 0, numItems);
        
    WebGLUniformLocation uColor = gl.getUniformLocation(program, "uColor");
    this.gl.uniform4fv(uColor, [this.foobar, this.foobar, 0.0, 1.0]);

    
    
    if (this.adding) {
      this.foobar += this.foobar / 100;
    } else {
      this.foobar -= this.foobar / 100;
    }
    
    if (this.foobar > 0.9) {
      this.adding = false;
    }
    
    if (this.foobar < 0.2) {
      this.adding = true;
    }
    
  }

  void run() {
    window.setInterval(f() => this.update(), 30);
    this.running = true;
  }
  
  
}

void main() {
  WebGLTest demo = new WebGLTest();
  demo.init();
  demo.run();
}
