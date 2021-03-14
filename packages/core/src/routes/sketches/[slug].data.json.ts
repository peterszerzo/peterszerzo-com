export function get(req, res) {
  // the `slug` parameter is available because
  // this file is called [slug].json.js
  const { slug } = req.params;

  res.end(
    JSON.stringify({
      slug,
    })
  );
}
