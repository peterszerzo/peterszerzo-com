import sketches from "../db/sketches.js";

export const get = (req, res, next) => {
  res.writeHead(200, {
    "Content-Type": "application/json"
  });

  res.end(
    JSON.stringify(
      sketches
        .filter(sketch => sketch.public)
        .map(sketch => ({
          slug: sketch.slug,
          title: sketch.title
        }))
    )
  );
};
