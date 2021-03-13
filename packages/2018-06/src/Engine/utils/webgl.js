const { Matrix4 } = window;

/**
 * Load a single shader.
 * @param {Object} gl - WebGL rendering context.
 * @param {number} type - Shader type, as a constate parameter gl.VERTEX_SHADER or gl.FRAGMENT_SHADER.
 * @param {String} source - Shader source code.
 * @returns {Object} shader - Shader.
 */
export function loadShader(gl, type, source) {
  const shader = gl.createShader(type);
  gl.shaderSource(shader, source);
  gl.compileShader(shader);
  const compiled = gl.getShaderParameter(shader, gl.COMPILE_STATUS);
  if (!compiled) {
    let error = gl.getShaderInfoLog(shader);
    console.log("Failed to compile shader: " + error);
    gl.deleteShader(shader);
    return null;
  }
  return shader;
}

/**
 * Initialize shaders
 * @param {Object} gl - WebGL rendering context.
 * @param {String} vShader - Vertex shader source code.
 * @param {String} fShader - Fragment shader source code.
 * @returns {Bool} success - Returns whether the initialization was successful.
 */
export function createProgram(gl, vShader, fFhader) {
  // Create shader object
  const vertexShader = loadShader(gl, gl.VERTEX_SHADER, vShader);
  const fragmentShader = loadShader(gl, gl.FRAGMENT_SHADER, fFhader);
  if (!vertexShader || !fragmentShader) {
    return null;
  }

  // Create a program object
  const program = gl.createProgram();
  if (!program) {
    return null;
  }

  // Attach the shader objects
  gl.attachShader(program, vertexShader);
  gl.attachShader(program, fragmentShader);

  // Link the program object
  gl.linkProgram(program);

  gl.enable(gl.DEPTH_TEST);

  // Check the result of linking
  const linked = gl.getProgramParameter(program, gl.LINK_STATUS);
  if (!linked) {
    let error = gl.getProgramInfoLog(program);
    console.log("Failed to link program: " + error);
    gl.deleteProgram(program);
    gl.deleteShader(fragmentShader);
    gl.deleteShader(vertexShader);
    return null;
  }

  if (!program) {
    console.log("Failed to create program");
    return false;
  }
  gl.useProgram(program);
  gl.program = program;
  return program;
}

/**
 * Vertex shader source.
 */
const vertexShaderSource = `
uniform mat4 u_Perspective;
uniform mat4 u_Transform;
uniform vec3 u_LightDirection;
attribute vec4 a_Position;
attribute vec4 a_Normal;
attribute vec4 a_Color;
varying vec4 v_Color;
void main() {
  vec4 lightDirection = normalize(vec4(u_LightDirection, 0.0));
  gl_Position = u_Perspective * (u_Transform * a_Position);
  float brightness = 0.55 - dot(lightDirection, normalize(a_Normal)) * 0.45;
  v_Color = a_Color * brightness;
}
`;

/**
 * Fragment shader source.
 */
const fragmentShaderSource = `
precision mediump float;
varying vec4 v_Color;
void main() {
  gl_FragColor = v_Color;
}
`;

// Entry point
export function create(canvas) {
  const gl = canvas.getContext("webgl");
  createProgram(gl, vertexShaderSource, fragmentShaderSource);
  setLight(gl);
  setTransform(gl);
  return gl;
}

export function update(gl) {
  gl.clearColor(0, 0, 0, 0);
  gl.clear(gl.COLOR_BUFFER_BIT | gl.DEPTH_BUFFER_BIT);
}

const { PI, sin, cos } = Math;

export function setPerspective(gl, lat, lng) {
  const perspectiveMatrix = new Matrix4();
  perspectiveMatrix.setPerspective(24, 1, 1, 100);
  const sinLng = sin((lng * PI) / 180);
  const cosLng = cos((lng * PI) / 180);
  const sinLat = sin((lat * PI) / 180);
  const cosLat = cos((lat * PI) / 180);
  perspectiveMatrix.lookAt(
    3 * cosLat * cosLng,
    3 * cosLat * sinLng,
    3 * sinLat,
    0,
    0,
    0,
    0,
    0,
    1
  );
  const uPerspective = gl.getUniformLocation(gl.program, "u_Perspective");
  gl.uniformMatrix4fv(uPerspective, false, perspectiveMatrix.elements);
}

function setTransform(gl, matrix) {
  const uTransform = gl.getUniformLocation(gl.program, "u_Transform");
  gl.uniformMatrix4fv(
    uTransform,
    false,
    (matrix && matrix.elements) || new Matrix4().elements
  );
}

function setLight(gl) {
  const uLightDirection = gl.getUniformLocation(gl.program, "u_LightDirection");
  gl.uniform3fv(uLightDirection, new Float32Array([0.2, 0.2, 1]));
}

/**
 * Draw a shape
 * @param {Object} gl - WebGL rendering context.
 * @param {Object} shape - Shape object.
 * @param {Matrix4} transform - Base transform for the shape. Replaces current transform uniform value in the vertex shader.
 */
export function drawShape(gl, shape, transform) {
  setTransform(gl, transform);
  const vertexBuffer = gl.createBuffer();
  gl.bindBuffer(gl.ARRAY_BUFFER, vertexBuffer);
  gl.bufferData(gl.ARRAY_BUFFER, shape.vertices, gl.STATIC_DRAW);

  const FSIZE = shape.vertices.BYTES_PER_ELEMENT;

  const aPosition = gl.getAttribLocation(gl.program, "a_Position");
  if (aPosition < 0) {
    console.log("Failed to get storage location for a_Position.");
  }
  gl.vertexAttribPointer(aPosition, 3, gl.FLOAT, false, FSIZE * 10, 0);
  gl.enableVertexAttribArray(aPosition);

  const aNormal = gl.getAttribLocation(gl.program, "a_Normal");
  if (aNormal < 0) {
    console.log("Failed to get storage location for a_Normal.");
  }
  gl.vertexAttribPointer(aNormal, 3, gl.FLOAT, false, FSIZE * 10, FSIZE * 3);
  gl.enableVertexAttribArray(aNormal);

  const aColor = gl.getAttribLocation(gl.program, "a_Color");
  if (aColor < 0) {
    console.log("Failed to get storage location for a_Color.");
  }
  gl.vertexAttribPointer(aColor, 3, gl.FLOAT, false, FSIZE * 10, FSIZE * 7);
  gl.enableVertexAttribArray(aColor);

  gl.bindBuffer(gl.ARRAY_BUFFER, null);

  if (shape.connectivity) {
    const indexBuffer = gl.createBuffer();
    gl.bindBuffer(gl.ELEMENT_ARRAY_BUFFER, indexBuffer);
    gl.bufferData(gl.ELEMENT_ARRAY_BUFFER, shape.connectivity, gl.STATIC_DRAW);
    gl.drawElements(
      gl.TRIANGLES,
      shape.connectivity.length,
      gl.UNSIGNED_BYTE,
      0
    );
  } else {
    gl.drawArrays(gl.TRIANGLES, 0, shape.vertices.length / 10);
  }
}
